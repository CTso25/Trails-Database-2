USE parks;

-- populate park table

INSERT INTO park (park_name, phone, description)
VALUES
	('Acadia National Park', '207-288-3338', "Southwest of Maine's Bar Harbor, Acadia was the first 
    national park East of the Mississippi, and the only one in the Northeast."),
    ('Yellowstone National Park', '307-344-7381', 'Yellowstone was the first national park in the US and draws millions of visitors
    due to its wildlife and geothermal characteristics'),
    ('Yosemite National Park', '209-372-0200', 'With nearly 95% of the park designated as wilderness, Yosemite is famous for its granite cliffs, waterfalls,
    and diverse wildlife.'),
    ('Zion National Park', '435-772-3256', "Zion's 229-squre-miles hold canyons with reddish sandstone, and features
    mountains, canyons, arches, and rivers.");
    
-- populate state table

INSERT INTO state (state, abbreviation)
VALUES
	('California', 'CA'),
    ('Idaho', 'ID'),
    ('Maine', 'ME'),
    ('Montana', 'MT'),
    ('Utah', 'UT'),
    ('Wyoming', 'WY');

-- populate park_state table

INSERT INTO park_state (park_id, state_id)
VALUES
	(1, 3),
    (2, 2),
    (2, 4),
    (2, 5),
    (3, 1), 
    (4, 4);
    
-- populate entrance table

INSERT INTO entrance (park_id, entrance_name, lat, lon)
VALUES
	(1, 'Sand Beach Entrance Station', 44.338797, -68.183168),
    (1, 'Bar Harbor Town Pier', 44.392087, -68.204052),
    (2, 'Yellowstone East Entrance', 44.4884500, -110.0038333),
    (2, 'Yellowstone North Entrance', 45.0295528, 110.7087000),
    (2, 'Yellowstone Northeast Entrance', 45.0033583, -110.0012833),
    (2, 'Yellowstone South Entrance', 44.1324917, -110.6646750),
    (2, 'Yellowstone West Entrance', 44.6584083, -111.0971861),
    (3, 'Hetch Hetchy Entrance', 37.948056, -119.788056),
    (3, 'Big Oak Flat Entrance', 37.8010364, -119.8732345),
    (3, 'Arch Rock Entrance', 37.68740, -119.72958),
    (3, 'Yosemite South Entrance', 37.5070, 119.6321),
    (3, 'Tioga Pass Entrance', 37.911111, -119.258056),
    (4, 'Zion Canyon Visitor Center', 37.2000907, -112.989187),
    (4, 'Kolob Canyon Visitor Center', 37.4226, 113.1537);
    
-- populate visitor center table

INSERT INTO visitor_center (park_id, viscenter_name)
VALUES
	(1, 'Hulls Cover Visitor Center'),
    (1, 'Thompson Island Visitor Center'),
    (1, 'Sieur de Monts Nature Center'), 
    (1, 'Rockefeller Welcome Center'),
    (2, 'Albright Visitor Center'),
    (2, 'Canyon Visitor Education Center'),
    (2, 'Fishing Bridge Visitor Center'), 
    (2, 'Grant Visitor Center'),
    (2, 'West Yellowstone Visitor Info Center'),
    (3, 'Valley Visitor Center'),
    (3, 'Wawona Visitor Center'),
    (4, 'Zion Canyon Visitor Center'),
    (4, 'Kolob Canyon Visitor Center');
    
-- skip parking for now
    
-- populate accomodation table

INSERT INTO accommodation (park_id, accommodation_name, type)
VALUES
	(1, 'Bar Harbor Campground', 'Campground'),
    (1, 'Bar Harbor Oceanside KOA','Campground'),
    (1, 'Bar Harbor Woodlands KOA','Campground'),
    (1, 'Bass Harbor Campground', 'Campground'),
    (1, "Hadley's Point Campground", 'Campground'),
    (1, 'Mount Desert Campground','Campground'),
    (1, 'Mt. Desert Narrows Camping Resort','Campground'),
    (1, 'Narrows Too Camping Resort', 'Campground'),
    (1, 'Quietside Campground & Cabins', 'Campground'),
    (1, 'Smugglers Den Campground','Campground'),
    (1, 'Somes Sound View Campground', 'Campground'),
    (2, 'Canyon Lodge', 'Lodge'),
    (2, 'Grant Village Lodge', 'Lodge'),
    (2, 'Lake Hotel', 'Lodge'),
    (2, 'Lake Lodge', 'Lodge'),
    (2, 'Mammoth Hotel and Cabins', 'Lodge'), 
    (2, 'Old Faithful Inn', 'Lodge'),
    (2, 'Old Faithful Lodge', 'Lodge'),
    (2, 'Old Faithful Snow Lodge', 'Lodge'),
    (2, 'Roosevelt Lodge', 'Lodge'),
    (2, 'Bridge Bay Campground', 'Campground'),
    (2, 'Canyon Campground', 'Campground'),
    (2, 'Fishing Bridge RV Park', 'RV Park'),
    (2, 'Grant Village Campground', 'Campground'),
    (2, 'Indian Creek Campground', 'Campground'),
    (2, 'Lewis Lake Campground', 'Campground'),
    (2, 'Madison Campground', 'Campground'),
    (2, 'Mammoth Campground', 'Campground'),
    (2, 'Norris Campground', 'Campground'),
    (2, 'Pebble Creek Campground', 'Campground'),
    (2, 'Slough Creek Campground', 'Campground'),
    (2, 'Tower Fall Campground', 'Campground'),
    (3, 'The Ahwahnee', 'Lodge'),
    (3, 'Yosemite Valley Lodge', 'Lodge'),
    (3, 'Wawona Hotel', 'Lodge'),
    (3, 'Curry Village', 'Lodge'),
    (3, 'Housekeeping Camp', 'Lodge'),
    (3, 'White Wolf Lodge', 'Lodge'),
    (3, 'Tuolumne Meadows Lodge', 'Lodge'),
    (3, 'High Sierra Camps', 'Lodge'),
    (3, 'Glacier Point Ski Hut', 'Lodge'),
    (3, 'Upper Pines', 'Campground'),
    (3, 'Lower Pines','Campground'),
    (3, 'North Pines', 'Campground'),
    (3, 'Camp 4', 'Campground'),
    (3, 'Wawona', 'Campground'),
    (3, 'Bridalveil Creek', 'Campground'),
    (3, 'Hodgdon Meadow', 'Campground'),
    (3, 'Crane Flat', 'Campground'),
    (3, 'Tamarack Flat', 'Campground'),
    (3, 'White Wolf', 'Campground'),
    (3, 'Yosemite Creek', 'Campground'),
    (3, 'Porcupine Flat', 'Campground'),
    (3, 'Tuolumne Meadows', 'Campground'),
    (4, 'South Campground', 'Campground'),
    (4, 'Watchman Campground', 'Campground'),
    (4, 'Lava Point Campground', 'Campground');


-- skip trail_has_feature table

INSERT INTO feature (feature)
VALUES
	('Waterfall'),
    ('Gorge'),
    ('Alpine Zone'),
    ('Scrambling'),
    ('River'), 
    ('Canyon'),
    ('Climbing'),
    ('Water Source'),
    ('Beach'),
    ('Cliffs'),
    ('Scenic Views'),
    ('Fishing'),
    ('Forest'),
    ('Rocky'),
    ('Wild Flowers'),
    ('Bird Watching'),
    ('Natural Pools'),
    ('Cave'),
    ('Bridge'),
    ('Lodge/Tea House'),
    ('Horseback Riding'),
    ('Lake'),
    ('Cross-Country Skiing'),
    ('Snowshoeing'),
    ('Geyser'),
    ('Hot Springs');
    
-- populate user table

-- INSERT INTO user (name, phone, email)
-- VALUES
-- 	('John Bica', '987-654-3210', 'bica.ia@husky.neu.edu'),
--     ('Nicole Reitz', '123-456-7890', 'reitz.n@husky.neu.edu'),
--     ('Hannah Stoik', '781-777-7777', 'stoik.ha.husky.neu.edu'),
--     ('Christopher Tso', '617-529-1234', 'tso.ch@husky.neu.edu'),
--     ('John Rachlin', '444-555-2345', 'jrachlin@northeastern.edu'),
--     ('Tony Zhang', '949-292-5930', 'zhang.to@husky.neu.edu'),
--     ('Stanly Yu', '333-444-1230', 'yu.st@husky.neu.edu'),
--     ('Geoff Karb', '999-446-2938', 'karb.ge@husky.neu.edu'),
--     ('John Fake', '998-330-6214', 'fake.j@fakeemail.com');


-- populate animal table

INSERT INTO animal (animal_class, common_name)
VALUES 
	('mammal', 'deer'), ('mammal', 'skunk'), ('mammal', 'raccoon'), ('mammal', 'black bear'),
    ('mammal', 'bat'), ('mammal', 'vole'), ('mammal', 'mouse'), ('mammal', 'rat'),
    ('mammal', 'squirrel'), ('mammal', 'gopher'), ('mammal', 'marmot'), ('mammal', 'chipmunk'),
    ('mammal', 'shrew'), ('mammal', 'mole'), ('mammal', 'badger'), ('mammal', 'bobcat'),
    ('mammal', 'lynx'), ('mammal', 'cougar'), ('mammal', 'coyote'), ('mammal', 'grizzly bear'),
    ('mammal', 'weasel'), ('mammal', 'fox'), ('mammal', 'marten'), ('mammal', 'otter'), 
    ('mammal', 'wolverine'), ('mammal', 'wolf'), ('mammal', 'bison'), ('mammal', 'sheep'), ('mammal', 'elk'), 
    ('mammal', 'moose'), ('mammal', 'goat'), ('mammal', 'beaver'), 
    ('mammal', 'rabbit'), ('mammal', 'hare'), ('mammal', 'pika'), ('mammal', 'porcupine'), 
    ('mammal', 'mountain lion'), ('mammal', 'woodchuck'), 
    ('bird', 'hawk'), ('bird', 'swallow'), ('bird', 'swift'), ('bird', 'hummingbird'),
    ('bird', 'pigeon'), ('bird', 'quail'), ('bird', 'finch'), ('bird', 'raven'), ('bird', 'jay'),
    ('bird', 'sparrow'), ('bird', 'blackbird'), ('bird', 'oriole'), ('bird', 'warbler'), ('bird', 'starling'),
    ('bird', 'wren'), ('bird', 'bluebird'), ('bird', 'flicker'), ('bird', 'woodpecker'), 
    ('bird', 'sapsucker'), ('bird', 'owl'), ('bird', 'osprey'), ('bird', 'eagle'), ('bird', 'falcon'), 
    ('bird', 'swan'), ('bird', 'loon'), ('bird', 'dipper'), ('bird', 'crane'), ('bird', 'vulture'), 
    ('bird', 'grebe'), ('bird', 'mallard'), ('bird', 'goose'), ('bird', 'turkey'), ('bird', 'dove'), 
    ('bird', 'grosbeak'), ('bird', 'tanager'), 
    ('reptile', 'lizard'), ('reptile', 'garter snake'), ('reptile', 'rattlesnake'), ('reptile', 'bullsnake'), 
    ('reptile', 'boa'), ('reptile', 'gecko'), ('reptile', 'whiptail'), ('reptile', 'tortoise'), 
    ('reptile', 'kingsnake'), ('reptile', 'gophersnake'), 
    ('amphibian', 'frog'), ('amphibian', 'salamander'), ('amphibian', 'ensatine'), ('amphibian', 'newt'),
    ('amphibian', 'toad'), ('amphibian', 'spadefoot'), 
    ('fish', 'sucker'), ('fish', 'trout'), ('fish', 'sculpin'), ('fish', 'minnow'), ('fish', 'whitefish'),
    ('fish', 'grayling'), ('fish', 'catfish');


-- populate weather stations table

INSERT INTO weather_station (park_id, state_id, weather_st_name, lat, lon, altitude)
VALUES 
	(1, 3, 'McFarland Hill', 44.3769, -68.2608, 423.88451),
    (1, 3, 'Southwest Harbor 2.6 SE', 44.2517, -68.2945, 49.2126),
    (2, 6, 'Snake River', 44.13632, -110.66631, 6881.88976), 
    (2, 6, 'Bechler Wyoming', 44.15, -110.0467, 6399.93438),
    (2, 6, 'Crandall Wyoming', 44.8503, -109.6114, 6611.87664), 
    (2, 6, 'Yellowstone National Park East', 44.48874, -110.0038, 6954.06824),
    (2, 4, 'Black Bear', 44.51, -111.13, 8169.94751),
    (2, 6, 'Old Faithful', 44.45684, -110.83269, 7351.04987),
    (2, 4, 'West Yellowstone Gateway', 44.65654, -111.09019, 6679.13386),
    (2, 4, 'Madison Plateau', 44.59, -111.12, 7750),
    (2, 6, 'Grassy Lake', 44.13, -110.83, 7265.09186),
    (2, 6, 'Lewis Lake Divide', 44.21, -110.67, 7850.06562),
    (2, 6, 'Sylvan Road', 44.46, -110.14, 7120.07874),
    (2, 6, 'Yellowstone Lake', 44.54444, -110.42111, 7834.97375),
    (2, 6, 'Canyon', 44.72, -110.51, 7870.07874),
    (2, 6, 'Tower Falls', 44.91653, -110.42033, 6274.93438),
    (2, 6, 'Lamar Ranger Station', 44.89553, -110.23416, 6575.13123),
    (2, 6, 'Parker Peak', 44.73, -109.91, 9399.93438),
    (2, 4, 'Northeast Entrance', 45.01, -110.01, 7350.06562),
    (2, 6, 'Yellowstone Park Mammoth', 44.97668, -110.6964, 6194.88189),
    (2, 6, 'Thumb Divide', 44.37, -110.58, 7979.98688),
    (2, 6, 'Two Ocean Plateau', 44.15, -110.22, 9240.15748),
    (4, 5, 'Zion National Park', 37.2091, -112.9814, 4038.05774),
    (4, 5, 'Lava Point', 37.3917, -113.0389, 7700.131),
    (3, 1, 'White Wolf', 37.8511, -119.65, 8024.934),  
    (3, 1, 'Yosemite Park Headquarters', 37.75027, -119.58972, 4018.04462),
    (3, 1, 'Jerseydale', 37.5436, -119.8386, 3899.93438), 
    (3, 1, 'South Entrance', 37.5122, -119.6331, 5046.91601),
    (3, 1, 'Mammoth Lakes', 37.6478, -118.9617, 7804.13386),
    (3, 1, 'Lee Vining', 37.9567, -119.1194, 6796.91601),
    (3, 1, 'Virginia Lakes Ridge', 38.07, -119.23, 9444.88189),
    (3, 1, 'Crane Flat Lookout', 37.7617, -119.8247, 6644.02887);
    
    



    
