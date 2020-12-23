use parks;

drop function if exists get_messages;

delimiter //

create function get_messages
(
	trail_id_param int
    
)
returns varchar(1000)
deterministic
begin
	declare message varchar(1000);
    declare alpine_bool varchar(10);
    declare distance_var int;
    declare permit_req_var varchar(50);
    declare trail_name_var varchar(150);
    
    select distance_miles, permit_required, trail
    into distance_var, permit_req_var, trail_name_var
    from trail
    where trail_id = trail_id_param;
    
    if (3 in (
		select feature_id
        from trail join trail_has_feature using (trail_id)
        where trail_id = trail_id_param
        ) ) then set alpine_bool = 'True';
	else set alpine_bool = 'False';
	end if;
    
    case
		when (alpine_bool = 'True' and distance_var >= 10 and permit_req_var = 'Yes') 
			then select concat(trail_name_var,
				' requires a permit. Please consult with Park Rangers before attempting this trail. ', 
                trail_name_var,' is a long hike. Consider doing this trail over multiple days. ',
                trail_name_var,' goes above Alpine Zone. Please use caution.') into message;
		when (alpine_bool = 'True' and distance_var >= 10 and permit_req_var = 'No')
			then select concat(trail_name_var,
				' is a long hike. Consider doing this trail over multiple days. ',
                trail_name_var,' goes above Alpine Zone. Please use caution.') into message;
		when (alpine_bool = 'True' and distance_var < 10 and permit_req_var = 'Yes')
			then select concat(trail_name_var,
				' requires a permit. Please consult with Park Rangers before attempting this trail. ',
                trail_name_var,' goes above Alpine Zone. Please use caution.') into message;
		when (alpine_bool = 'True' and distance_var < 10 and permit_req_var = 'No')
			then select concat(trail_name_var,' goes above Alpine Zone. Please use caution.') into message;
		when (alpine_bool = 'False' and distance_var >= 10 and permit_req_var = 'Yes') 
			then select concat(trail_name_var,
				' requires a permit. Please consult with Park Rangers before attempting this trail. ', 
                trail_name_var,' is a long hike. Consider doing this trail over multiple days.') into message;
		when (alpine_bool = 'False' and distance_var >= 10 and permit_req_var = 'No') 
			then select concat(trail_name_var,
				' is a long hike. Consider doing this trail over multiple days.') into message;
		when (alpine_bool = 'False' and distance_var < 10 and permit_req_var = 'Yes')
			then select concat(trail_name_var,
				' requires a permit. Please consult with Park Rangers before attempting this trail.') into message;
		when (alpine_bool = 'False' and distance_var < 10 and permit_req_var = 'No') 
			then select concat('Have fun hiking ', trail_name_var, '!') into message;
	end case;
        
    return message;

end //

delimiter ;


drop function if exists get_features;

delimiter //

create function get_features
(
	trail_id_param int,
    feature_id_1_param int,
    feature_id_2_param int,
    feature_id_3_param int,
    feature_id_4_param int,
    feature_id_5_param int
)
returns varchar(1000)
deterministic
begin
	declare message varchar(1000);
    declare trail_name_var varchar(150);
    declare feat_1_var varchar(150);
    declare feat_2_var varchar(150);
    declare feat_3_var varchar(150);
    declare feat_4_var varchar(150);
    declare feat_5_var varchar(150);
    
    select trail into trail_name_var from trail where trail_id = trail_id_param;
    
    if (feature_id_1_param is not null and feature_id_1_param in 
		(select feature_id from trail_has_feature where trail_id = trail_id_param)) then
		select feature into feat_1_var from feature where feature_id = feature_id_1_param;
	else set feat_1_var = Null;
    end if;

    if (feature_id_2_param is not null and feature_id_2_param in 
		(select feature_id from trail_has_feature where trail_id = trail_id_param)) then
		select feature into feat_2_var from feature where feature_id = feature_id_2_param;
	else set feat_2_var = Null;
    end if;
	
    if (feature_id_3_param is not null and feature_id_3_param in 
		(select feature_id from trail_has_feature where trail_id = trail_id_param)) then
		select feature into feat_3_var from feature where feature_id = feature_id_3_param;
	else set feat_3_var = Null;
    end if;
	
    if (feature_id_4_param is not null and feature_id_4_param in 
		(select feature_id from trail_has_feature where trail_id = trail_id_param)) then
		select feature into feat_4_var from feature where feature_id = feature_id_4_param;
	else set feat_4_var = Null;
    end if;
	
    if (feature_id_5_param is not null and feature_id_5_param in 
		(select feature_id from trail_has_feature where trail_id = trail_id_param)) then
		select feature into feat_5_var from feature where feature_id = feature_id_5_param;
	else set feat_5_var = Null;
    end if;

	case
		when (feat_1_var is not null and feat_2_var is not null and feat_3_var is not null
			and feat_4_var is not null and feat_5_var is not null) then
            select concat(trail_name_var,' has ',feat_1_var,' , ',feat_2_var,' , ',feat_3_var,' , ',
				feat_4_var,' , ',feat_5_var, ' as features.') into message;
		when (feat_1_var is not null and feat_2_var is not null and feat_3_var is not null
			and feat_4_var is not null and feat_5_var is null) then
            select concat(trail_name_var,' has ',feat_1_var,' , ',feat_2_var,' , ',feat_3_var,' , ',
				feat_4_var, ' as features.') into message;
		when (feat_1_var is not null and feat_2_var is not null and feat_3_var is not null
			and feat_4_var is null and feat_5_var is null) then
            select concat(trail_name_var,' has ',feat_1_var,' , ',feat_2_var,' , ',feat_3_var,
				' as features.') into message;
		when (feat_1_var is not null and feat_2_var is not null and feat_3_var is null
			and feat_4_var is null and feat_5_var is null) then
            select concat(trail_name_var,' has ',feat_1_var,' and ',feat_2_var,
				' as features.') into message;
		when (feat_1_var is not null and feat_2_var is null and feat_3_var is null
			and feat_4_var is null and feat_5_var is null) then
            select concat(trail_name_var,' has ',feat_1_var,' as a feature.') into message;
		when (feat_1_var is null and feat_2_var is not null and feat_3_var is not null
			and feat_4_var is not null and feat_5_var is not null) then
            select concat(trail_name_var,' has ',feat_2_var,' , ',feat_3_var,' , ',
				feat_4_var,' , ',feat_5_var, ' as features.') into message;
		when (feat_1_var is null and feat_2_var is not null and feat_3_var is not null
			and feat_4_var is not null and feat_5_var is null) then
            select concat(trail_name_var,' has ',feat_2_var,' , ',feat_3_var,' , ',
				feat_4_var,' as features.') into message;
		when (feat_1_var is null and feat_2_var is not null and feat_3_var is not null
			and feat_4_var is null and feat_5_var is null) then
            select concat(trail_name_var,' has ',feat_2_var,' and ',feat_3_var,
				' as features.') into message;
		when (feat_1_var is null and feat_2_var is not null and feat_3_var is null
			and feat_4_var is null and feat_5_var is null) then
            select concat(trail_name_var,' has ',feat_2_var,' as a feature.') into message;
		when (feat_1_var is null and feat_2_var is null and feat_3_var is not null
			and feat_4_var is not null and feat_5_var is not null) then
            select concat(trail_name_var,' has ',feat_3_var,' , ',
				feat_4_var,' , ',feat_5_var, ' as features.') into message;
		when (feat_1_var is null and feat_2_var is null and feat_3_var is not null
			and feat_4_var is not null and feat_5_var is null) then
            select concat(trail_name_var,' has ',feat_3_var,' and ',
				feat_4_var, ' as features.') into message;
		when (feat_1_var is null and feat_2_var is null and feat_3_var is not null
			and feat_4_var is null and feat_5_var is null) then
            select concat(trail_name_var,' has ',feat_3_var,' as a feature.') into message;
		when (feat_1_var is null and feat_2_var is null and feat_3_var is null
			and feat_4_var is not null and feat_5_var is not null) then
            select concat(trail_name_var,' has ',feat_4_var,' and ',feat_5_var, ' as features.') into message;
		when (feat_1_var is null and feat_2_var is null and feat_3_var is null
			and feat_4_var is not null and feat_5_var is null) then
            select concat(trail_name_var,' has ',feat_4_var, ' as a feature.') into message;
		when (feat_1_var is null and feat_2_var is null and feat_3_var is null
			and feat_4_var is null and feat_5_var is not null) then 
            select concat(trail_name_var,' has ',feat_5_var, ' as a feature.') into message;
		when (feat_1_var is not null and feat_2_var is null and feat_3_var is not null
			and feat_4_var is not null and feat_5_var is not null) then
            select concat(trail_name_var,' has ',feat_1_var,' , ',feat_3_var,' , ',
				feat_4_var,' , ',feat_5_var, ' as features.') into message;
		when (feat_1_var is not null and feat_2_var is null and feat_3_var is null
			and feat_4_var is not null and feat_5_var is not null) then
            select concat(trail_name_var,' has ',feat_1_var,' , ',
				feat_4_var,' , ',feat_5_var, ' as features.') into message;
		when (feat_1_var is not null and feat_2_var is null and feat_3_var is null
			and feat_4_var is null and feat_5_var is not null) then
            select concat(trail_name_var,' has ',feat_1_var,' and ',feat_5_var, ' as features.') into message;
		when (feat_1_var is not null and feat_2_var is null and feat_3_var is not null
			and feat_4_var is null and feat_5_var is not null) then
            select concat(trail_name_var,' has ',feat_1_var,' , ',feat_3_var,' , ',
				feat_5_var, ' as features.') into message;
		when (feat_1_var is not null and feat_2_var is null and feat_3_var is not null
			and feat_4_var is null and feat_5_var is null) then
            select concat(trail_name_var,' has ',feat_1_var,' and ',feat_3_var,' as features.') into message;
		when (feat_1_var is null and feat_2_var is not null and feat_3_var is null
			and feat_4_var is not null and feat_5_var is not null) then
            select concat(trail_name_var,' has ',feat_2_var,' , ',
				feat_4_var,' , ',feat_5_var, ' as features.') into message;
		when (feat_1_var is null and feat_2_var is not null and feat_3_var is null
			and feat_4_var is null and feat_5_var is not null) then
            select concat(trail_name_var,' has ',feat_2_var,' and ',feat_5_var, ' as features.') into message;
		when (feat_1_var is null and feat_2_var is not null and feat_3_var is null
			and feat_4_var is not null and feat_5_var is null) then
            select concat(trail_name_var,' has ',feat_2_var,' and ',feat_4_var, ' as features.') into message;
		when (feat_1_var is null and feat_2_var is null and feat_3_var is not null
			and feat_4_var is null and feat_5_var is not null) then
            select concat(trail_name_var,' has ',feat_3_var,' and ',feat_5_var, ' as features.') into message;
                
	end case;
        
    return message;

end //

delimiter ;




drop procedure if exists find_hike;

delimiter //

create procedure find_hike
(
	in park_param varchar(250),
    in difficulty_param ENUM('Easy', 'Moderate', 'Hard'),
    in dist_min_param decimal(4,2),
    in dist_max_param decimal(4,2),
    in bathroom_param ENUM('Yes', 'No', 'No preference'),
    in dog_param ENUM('Yes', 'No', 'No preference'),
    in feature_param varchar(250)
)
begin
	declare park_id_var int;
    declare feature_id_var int;
    declare message varchar(255);
    
	-- check valid input parameters

	if (park_param not in (SELECT park_name FROM park)) then
		select concat(park_param, ' is not a valid park name.') into message;
        signal sqlstate 'HY000' set message_text = message;
	end if;
    
    if (feature_param not in (select feature from feature)) then 
		select concat(feature_param, ' is not a valid feature.') into message;
        signal sqlstate 'HY000' set message_text = message;
	end if;
    
    if (dist_min_param > dist_max_param) then
		select concat(dist_min_param, ' is larger than ', dist_max_param, '. Please reveiw.') into message;
        signal sqlstate 'HY000' set message_text = message;
	end if;

    -- select relevant values into variables
    
	select park_id
    into park_id_var
    from park
    where park_name = park_param;
    
    select feature_id
    into feature_id_var
    from feature
    where feature = feature_param;
    
	select 
		trail.trail 'trail name', 
        trail.distance_miles 'distance in miles', 
        trail.description, 
        avg(review.star_rating) 'average user rating',
        get_messages(trail.trail_id) 'messages'
    from trail left join trail_has_feature using (trail_id)
    left join review using (trail_id)
    where trail.park_id = park_id_var
    and trail_has_feature.feature_id = feature_id_var
    and trail.distance_miles between dist_min_param and dist_max_param
    and trail.difficulty = difficulty_param
    and 1 = CASE
		WHEN (dogs_allow = 'Yes' and (dog_param = 'Yes' or dog_param = 'No preference')) then 1
        WHEN (dogs_allow = 'No' and (dog_param = 'No' or dog_param = 'No preference')) then 1
        ELSE 0
        END
	and 1 = CASE
		WHEN (bathrooms = 'Yes' and (bathroom_param = 'Yes' or bathroom_param = 'No preference')) then 1
		WHEN (bathrooms = 'No' and (bathroom_param = 'No' or bathroom_param = 'No preference')) then 1
		ELSE 0
		END
	group by trail.trail_id
    order by avg(review.star_rating) DESC
    -- limit 5
    ;
  
  IF found_rows() = 0 then select 'No matching trails found.' as status;
  END IF;
    
    
end //

DELIMITER ;

call find_hike('Yosemite National Park', 'Easy', 0.5, 10, 'No preference', 'No preference', 'Waterfall');

drop procedure if exists find_better_hike;

delimiter //

create procedure find_better_hike
(
	in park_param varchar(250),
    in difficulty_param ENUM('Easy', 'Moderate', 'Hard'),
    in dist_min_param decimal(4,2),
    in dist_max_param decimal(4,2),
    in bathroom_param ENUM('Yes', 'No', 'No preference'),
    in dog_param ENUM('Yes', 'No', 'No preference'),
    in feature_param_1 varchar(250),
    in feature_param_2 varchar(250),
    in feature_param_3 varchar(250),
    in feature_param_4 varchar(250),
    in feature_param_5 varchar(250)
)
begin
	declare park_id_var int;
    declare feature_id_var_1 int;
    declare feature_id_var_2 int;
    declare feature_id_var_3 int;
    declare feature_id_var_4 int;
    declare feature_id_var_5 int;
    declare message varchar(255);
    
	-- check valid input parameters

	if (park_param not in (SELECT park_name FROM park)) then
		select concat(park_param, ' is not a valid park name.') into message;
        signal sqlstate 'HY000' set message_text = message;
	end if;
    
    if (feature_param_1 is not null and feature_param_1 not in (select feature from feature)) then 
		select concat(feature_param_1, ' is not a valid feature.') into message;
        signal sqlstate 'HY000' set message_text = message;
	end if;
    
	if (feature_param_2 is not null and feature_param_2 not in (select feature from feature)) then 
		select concat(feature_param_2, ' is not a valid feature.') into message;
        signal sqlstate 'HY000' set message_text = message;
	end if;
 
	if (feature_param_3 is not null and feature_param_3 not in (select feature from feature)) then 
		select concat(feature_param_3, ' is not a valid feature.') into message;
        signal sqlstate 'HY000' set message_text = message;
	end if;
    
	if (feature_param_4 is not null and feature_param_4 not in (select feature from feature)) then 
		select concat(feature_param_4, ' is not a valid feature.') into message;
        signal sqlstate 'HY000' set message_text = message;
	end if;
    
	if (feature_param_5 is not null and feature_param_5 not in (select feature from feature)) then 
		select concat(feature_param_5, ' is not a valid feature.') into message;
        signal sqlstate 'HY000' set message_text = message;
	end if;
 
    if (dist_min_param > dist_max_param) then
		select concat(dist_min_param, ' is larger than ', dist_max_param, '. Please reveiw.') into message;
        signal sqlstate 'HY000' set message_text = message;
	end if;

    -- select relevant values into variables
    
	select park_id
    into park_id_var
    from park
    where park_name = park_param;
 
	if (feature_param_1 is not null) then
		select feature_id
		into feature_id_var_1
		from feature
		where feature = feature_param_1;
	else set feature_id_var_1 = Null;
	end if;
    
	if (feature_param_2 is not null) then
		select feature_id
		into feature_id_var_2
		from feature
		where feature = feature_param_2;
	else set feature_id_var_2 = Null;
	end if;
    
	if (feature_param_3 is not null) then
		select feature_id
		into feature_id_var_3
		from feature
		where feature = feature_param_3;
	else set feature_id_var_3 = Null;
	end if;
    
	if (feature_param_4 is not null) then
		select feature_id
		into feature_id_var_4
		from feature
		where feature = feature_param_4;
	else set feature_id_var_4 = Null;
	end if;
    
	if (feature_param_5 is not null) then
		select feature_id
		into feature_id_var_5
		from feature
		where feature = feature_param_5;
	else set feature_id_var_5 = Null;
	end if;
    
	select 
		trail.trail 'trail name', 
        trail.distance_miles 'distance in miles', 
        trail.description, 
        round(avg(review.star_rating), 2) 'average user rating',
        get_features(trail.trail_id, feature_id_var_1, feature_id_var_2, feature_id_var_3, 
			feature_id_var_4, feature_id_var_5) 'features',
        get_messages(trail.trail_id) 'messages'
    from trail left join trail_has_feature using (trail_id)
    left join review using (trail_id)
    where trail.park_id = park_id_var
    and 1 = CASE
		WHEN ((trail_has_feature.feature_id = feature_id_var_1 and feature_id_var_1 is not null) or
		(trail_has_feature.feature_id = feature_id_var_2 and feature_id_var_2 is not null) or
		(trail_has_feature.feature_id = feature_id_var_3 and feature_id_var_3 is not null) or
		(trail_has_feature.feature_id = feature_id_var_4 and feature_id_var_4 is not null) or
        (trail_has_feature.feature_id = feature_id_var_5 and feature_id_var_5 is not null)) then 1
		ELSE 0
        END
    and trail.distance_miles between dist_min_param and dist_max_param
    and trail.difficulty = difficulty_param
    and 1 = CASE
		WHEN (dogs_allow = 'Yes' and (dog_param = 'Yes' or dog_param = 'No preference')) then 1
        WHEN (dogs_allow = 'No' and (dog_param = 'No' or dog_param = 'No preference')) then 1
        ELSE 0
        END
	and 1 = CASE
		WHEN (bathrooms = 'Yes' and (bathroom_param = 'Yes' or bathroom_param = 'No preference')) then 1
		WHEN (bathrooms = 'No' and (bathroom_param = 'No' or bathroom_param = 'No preference')) then 1
		ELSE 0
		END
	group by trail.trail_id
    order by avg(review.star_rating) DESC
    -- limit 5
    ;
  
  IF found_rows() = 0 then select 'No matching trails found.' as status;
  END IF;
    
    
end //

DELIMITER ;


-- Procedure to insert qr_codes
drop procedure if exists qr_insert;

delimiter //
create procedure qr_insert
(
in name_param varchar(255),
in qr_id_param int
)
begin
	declare user_id_var int;
    declare message varchar(255);

-- select into statements

	SELECT user_id
    INTO user_id_var
    FROM user
    WHERE user.name = name_param;
    
-- message for no known user
    IF (name_param not in (SELECT name FROM user)) then 
		select concat('Please register first!') into message;
		signal sqlstate 'HY000' set message_text = message;
	end if;

-- if no errors then insert into check_in
	INSERT INTO check_in (QR_id, user_id, timestamp)
    VALUES (qr_id_param, user_id_var, sysdate());
    
	SELECT 'You have successfully checked in!';
END //
DELIMITER ;




drop procedure if exists find_best_hike;

delimiter //

create procedure find_best_hike
(
	in park_param varchar(250),
    in difficulty_param ENUM('Easy', 'Moderate', 'Hard'),
    in dist_min_param decimal(4,2),
    in dist_max_param decimal(4,2),
    in bathroom_param ENUM('Yes', 'No', 'No preference'),
    in dog_param ENUM('Yes', 'No', 'No preference'),
    in feature_param_1 varchar(250),
    in feature_param_2 varchar(250),
    in feature_param_3 varchar(250),
    in feature_param_4 varchar(250),
    in feature_param_5 varchar(250)
)
begin
	declare park_id_var int;
    declare feature_id_var_1 int;
    declare feature_id_var_2 int;
    declare feature_id_var_3 int;
    declare feature_id_var_4 int;
    declare feature_id_var_5 int;
    declare message varchar(255);
    
	-- check valid input parameters

	if (park_param not in (SELECT park_name FROM park)) then
		select concat(park_param, ' is not a valid park name.') into message;
        signal sqlstate 'HY000' set message_text = message;
	end if;
    
    if (feature_param_1 is not null and feature_param_1 NOT LIKE 'None' and feature_param_1 not in (select feature from feature)) then 
		select concat(feature_param_1, ' is not a valid feature.') into message;
        signal sqlstate 'HY000' set message_text = message;
	end if;
    
	if (feature_param_2 is not null and feature_param_2 NOT LIKE 'None' and feature_param_2 not in (select feature from feature)) then 
		select concat(feature_param_2, ' is not a valid feature.') into message;
        signal sqlstate 'HY000' set message_text = message;
	end if;
 
	if (feature_param_3 is not null and feature_param_3 NOT LIKE 'None' and feature_param_3 not in (select feature from feature)) then 
		select concat(feature_param_3, ' is not a valid feature.') into message;
        signal sqlstate 'HY000' set message_text = message;
	end if;
    
	if (feature_param_4 is not null and feature_param_4 NOT LIKE 'None' and feature_param_4 not in (select feature from feature)) then 
		select concat(feature_param_4, ' is not a valid feature.') into message;
        signal sqlstate 'HY000' set message_text = message;
	end if;
    
	if (feature_param_5 is not null and feature_param_5 NOT LIKE 'None' and feature_param_5 not in (select feature from feature)) then 
		select concat(feature_param_5, ' is not a valid feature.') into message;
        signal sqlstate 'HY000' set message_text = message;
	end if;
 
    if (dist_min_param > dist_max_param) then
		select concat(dist_min_param, ' is larger than ', dist_max_param, '. Please reveiw.') into message;
        signal sqlstate 'HY000' set message_text = message;
	end if;

    -- select relevant values into variables
    
	select park_id
    into park_id_var
    from park
    where park_name = park_param;
 
	if (feature_param_1 is not null and feature_param_1 NOT LIKE 'None') then
		select feature_id
		into feature_id_var_1
		from feature
		where feature = feature_param_1;
	else set feature_id_var_1 = Null;
	end if;
    
	if (feature_param_2 is not null and feature_param_2 NOT LIKE 'None') then
		select feature_id
		into feature_id_var_2
		from feature
		where feature = feature_param_2;
	else set feature_id_var_2 = Null;
	end if;
    
	if (feature_param_3 is not null and feature_param_3 NOT LIKE 'None') then
		select feature_id
		into feature_id_var_3
		from feature
		where feature = feature_param_3;
	else set feature_id_var_3 = Null;
	end if;
    
	if (feature_param_4 is not null and feature_param_4 NOT LIKE 'None') then
		select feature_id
		into feature_id_var_4
		from feature
		where feature = feature_param_4;
	else set feature_id_var_4 = Null;
	end if;
    
	if (feature_param_5 is not null and feature_param_5 NOT LIKE 'None') then
		select feature_id
		into feature_id_var_5
		from feature
		where feature = feature_param_5;
	else set feature_id_var_5 = Null;
	end if;
    
	select 
		trail.trail 'trail name', 
        trail.distance_miles 'distance in miles', 
        trail.description, 
        round(avg(review.star_rating), 2) 'average user rating',
        get_features(trail.trail_id, feature_id_var_1, feature_id_var_2, feature_id_var_3, 
			feature_id_var_4, feature_id_var_5) 'features',
        get_messages(trail.trail_id) 'messages'
    from trail left join trail_has_feature using (trail_id)
    left join review using (trail_id)
    where trail.park_id = park_id_var
    and 1 = CASE
		WHEN ((trail_has_feature.feature_id = feature_id_var_1 and feature_id_var_1 is not null) or
		(trail_has_feature.feature_id = feature_id_var_2 and feature_id_var_2 is not null) or
		(trail_has_feature.feature_id = feature_id_var_3 and feature_id_var_3 is not null) or
		(trail_has_feature.feature_id = feature_id_var_4 and feature_id_var_4 is not null) or
        (trail_has_feature.feature_id = feature_id_var_5 and feature_id_var_5 is not null)) then 1
		ELSE 0
        END
    and trail.distance_miles between dist_min_param and dist_max_param
    and trail.difficulty = difficulty_param
    and 1 = CASE
		WHEN (dogs_allow = 'Yes' and (dog_param = 'Yes' or dog_param = 'No preference')) then 1
        WHEN (dogs_allow = 'No' and (dog_param = 'No' or dog_param = 'No preference')) then 1
        ELSE 0
        END
	and 1 = CASE
		WHEN (bathrooms = 'Yes' and (bathroom_param = 'Yes' or bathroom_param = 'No preference')) then 1
		WHEN (bathrooms = 'No' and (bathroom_param = 'No' or bathroom_param = 'No preference')) then 1
		ELSE 0
		END
	group by trail.trail_id
    order by avg(review.star_rating) DESC
    -- limit 5
    ;
  
  IF found_rows() = 0 then select 'No matching trails found.' as status;
  END IF;
    
    
end //

DELIMITER ;


