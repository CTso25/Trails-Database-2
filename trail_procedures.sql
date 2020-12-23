use parks;

-- message for permit required

drop procedure if exists trailmessage_permit;

delimiter //

create procedure trailmessage_permit
(
in trail_name_param varchar(255)
)
begin
	declare trail_id_var int;
    declare permit_req_var varchar(50);
    declare message varchar(255);

-- select into statements
    
    SELECT trail_id, permit_required 
    INTO trail_id_var, permit_req_var
    FROM trail
    WHERE trail.trail = trail_name_param;

-- message for permit required
    
    if (permit_req_var = 'Yes') then 
		select concat(trail_name_param, ' requires a permit. Please consult with Park Rangers before attempting this trail.') as status;
   else
		select concat('No permit required for ', trail_name_param, '. Enjoy your hike!') as status;
	end if;

END //
DELIMITER ;

-- message for long distance

DROP PROCEDURE IF EXISTS trailmessage_distance;

delimiter //

create procedure trailmessage_distance
(
in trail_name_param varchar(255)
)
begin
	declare trail_id_var int;
    declare distance_miles_var DECIMAL(4,2);
    declare message varchar(255);

	-- select into statements
    
    SELECT trail_id, distance_miles 
    INTO trail_id_var, distance_miles_var
    FROM trail
    WHERE trail.trail = trail_name_param;
    
    -- message for long hike
    
    if (distance_miles_var >= 10) then
		select concat(trail_name_param, ' is a long hike. Consider doing this trail over multiple days.') into message;
		signal sqlstate 'HY000' set message_text = message;
	end if;
 
END //
DELIMITER ;

-- message for alpine zone

DROP PROCEDURE IF EXISTS trailmessage_alpine;

delimiter //

create procedure trailmessage_alpine
(
in trail_name_param varchar(255)
)
begin
	declare trail_id_var int;
    declare message varchar(255);

	-- select into statements
    
    SELECT trail_id
    INTO trail_id_var
    FROM trail
    WHERE trail.trail = trail_name_param;

    -- message for alpine 
    
    if (3 in 
		(
		select feature_id 
		from trail join trail_has_feature using (trail_id)
		where trail_id = trail_id_var
		) ) then 
		select concat('Portions of ', trail_name_param, ' go above Alpine Zone. Please use caution') into message;
		signal sqlstate 'HY000' set message_text = message;
	end if;
    
END //
DELIMITER ;

-- invalid star integer

DROP TRIGGER IF EXISTS invalid_star;

DELIMITER //

CREATE TRIGGER invalid_star
	BEFORE INSERT ON review
    FOR EACH ROW
BEGIN
	IF (NEW.star_rating NOT IN (1, 2, 3, 4, 5)) THEN
		SIGNAL SQLSTATE 'HY000'
			SET message_text = 'Star rating must be 1 through 5.';
	END IF;
END; //

DELIMITER ;


-- Procedure to insert animal spotting into spotting table

DROP PROCEDURE IF EXISTS add_spotting;

DELIMITER //

CREATE PROCEDURE add_spotting
(
in animal_name_param VARCHAR(255),
    in user_name_param VARCHAR(255),
    in trail_name_param VARCHAR(255),
    in quantity_param INT,
    in lat_param DECIMAL(10,7),
    in lon_param DECIMAL(10,7),
    in desc_param VARCHAR(255)
)
begin
	-- variable declarattions
	declare animal_id_var int;
    declare user_id_var int;
    declare trail_id_var int;
    
    -- select relevant values into variables
    select animal_id 
    into animal_id_var
    from animal
    where animal.common_name = animal_name_param;

	select user_id
    into user_id_var
    from user
    where user_name_param = user.name;
    
    if (trail_name_param IS NOT NULL) then
		select trail_id
		into trail_id_var
		from trail
		where trail_name_param = trail.trail;
    end if;
    
    if (trail_name_param IS NULL) then
		select trail_name_param into trail_id_var;
	end if;
    
    -- insert new spotting into table
    
    insert into spotting (animal_id, user_id, trail_id, quantity, lat, lon, description, time)
    values (animal_id_var, user_id_var, trail_id_var, quantity_param, lat_param, lon_param, desc_param, now());
    
	select concat(animal_name_param, ' spotting adding to spottings.') as status;

end //

DELIMITER ;


-- Procedure to insert reviews
drop procedure if exists review_insert;

delimiter //
create procedure review_insert
(
in name_param varchar (250),
in trail_name_param varchar(255),
in star_rating_param int,
in review_txt_param varchar(2000)
)

-- declare variables
begin
	declare user_id_var int;
    declare trail_id_var int;
    declare message varchar(255);

-- select into statements

	SELECT user_id
    INTO user_id_var
    FROM user
    WHERE user.name = name_param;
    
	SELECT trail_id
    INTO trail_id_var
    FROM trail
    WHERE trail.trail = trail_name_param;
    
-- message for no known user
    IF (name_param not in (SELECT name FROM user)) then 
		select concat('Please register first!') into message;
		signal sqlstate 'HY000' set message_text = message;
	end if;

-- message for non-existent trail 
    IF (trail_name_param not in (SELECT trail FROM trail)) then 
		select concat('Please review a known trail!') into message;
		signal sqlstate 'HY000' set message_text = message;
	end if;

-- if no errors then insert into reviews
	INSERT INTO review (user_id, trail_id, time, star_rating, review)
    VALUES (user_id_var, trail_id_var, sysdate(), star_rating_param, review_txt_param);
    
	SELECT 'Your review has been successfully recorded!';

END //
DELIMITER ;
