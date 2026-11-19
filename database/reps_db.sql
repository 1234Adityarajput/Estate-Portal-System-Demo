SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";
SET FOREIGN_KEY_CHECKS = 0;

-- --------------------------------------------------------
-- Table structure for table `agent_list`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `agent_list`;
CREATE TABLE `agent_list` (
  `id` int(30) NOT NULL AUTO_INCREMENT,
  `firstname` text NOT NULL,
  `middlename` text DEFAULT NULL,
  `lastname` text NOT NULL,
  `gender` text NOT NULL,
  `contact` text NOT NULL,
  `address` text NOT NULL,
  `email` text NOT NULL,
  `password` text NOT NULL,
  `avatar` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `agent_list` (`id`, `firstname`, `middlename`, `lastname`, `gender`, `contact`, `address`, `email`, `password`, `avatar`, `status`, `delete_flag`, `date_created`, `date_updated`) VALUES
(1, 'Mark', 'D', 'Cooper', 'Male', '09123456789', 'This is my sample address only.', 'mcooper@sample.com', 'c7162ff89c647f444fcaa5c635dac8c3', 'uploads/agents/1.jpg?v=1645241414', 1, 0, '2022-02-19 11:30:14', NULL);

-- --------------------------------------------------------
-- Table structure for table `amenity_list`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `amenity_list`;
CREATE TABLE `amenity_list` (
  `id` int(30) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `type` tinyint(1) DEFAULT 1 COMMENT '1 = indoor, 2 = outdoor',
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `amenity_list` (`id`, `name`, `type`, `status`, `delete_flag`, `date_created`) VALUES
(1, 'Master Bed Room', 1, 1, 0, '2022-02-19 09:45:33'),
(2, 'Guest Room', 1, 1, 0, '2022-02-19 09:45:42'),
(3, 'Living Room', 1, 1, 0, '2022-02-19 09:45:48'),
(4, 'Chimnry', 1, 1, 0, '2022-02-19 09:45:56'),
(5, 'Kitchen', 1, 1, 0, '2022-02-19 09:46:17'),
(6, 'Garage', 2, 1, 0, '2022-02-19 09:47:08'),
(7, 'Balcony', 2, 1, 0, '2022-02-19 09:47:15'),
(8, 'Pool', 2, 1, 0, '2022-02-19 09:47:30'),
(9, 'Garden Space', 2, 1, 0, '2022-02-19 09:47:43'),
(10, 'Internet', 1, 1, 0, '2022-02-19 09:52:07'),
(11, 'Washing Machine', 1, 1, 0, '2022-02-19 09:52:15'),
(12, 'Kids Playing Area', 1, 1, 0, '2022-02-19 09:52:39');

-- --------------------------------------------------------
-- Table structure for table `type_list`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `type_list`;
CREATE TABLE `type_list` (
  `id` int(30) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `description` text NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `type_list` (`id`, `name`, `description`, `status`, `delete_flag`, `date_created`, `date_updated`) VALUES
(1, 'Residential', 'Residential real estate refers to any property used for housing. These include family homes, cooperatives, duplexes, and condos where the investor or a party renting the property lives in. This type is ideal if you are looking to start building your dream home or begin a family. ', 1, 0, '2022-02-19 10:02:11', NULL),
(2, 'Commercial', 'Commercial real estate refers to any property where the main purpose is to host business operations and services. These properties typically include apartment complexes, stores, gas stations, hotels, hospitals, parking facilities, etc. ', 1, 0, '2022-02-19 10:02:33', NULL),
(3, 'Industrial', 'Industrial real estate refers to all lands, buildings, and other properties that accommodate industrial-sized activities. These activities include production, assembly, warehousing, manufacturing, research, and distribution of goods and products. ', 1, 0, '2022-02-19 10:02:48', NULL),
(4, 'Raw land', 'Raw land typically refers to undeveloped or agricultural land such as farms, ranches, and timberlands. Many investors look at these properties as a good investment because they are tangible and finite resources. Additionally, these properties save you from the trouble of running renovations and worrying over stolen or damaged goods. ', 1, 0, '2022-02-19 10:03:35', NULL);

-- --------------------------------------------------------
-- Table structure for table `real_estate_list`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `real_estate_list`;
CREATE TABLE `real_estate_list` (
  `id` int(30) NOT NULL AUTO_INCREMENT,
  `code` varchar(100) NOT NULL,
  `name` text NOT NULL,
  `type_id` int(30) NOT NULL,
  `agent_id` int(30) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 = Available, 2 = not Available',
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `type_id` (`type_id`),
  KEY `agent_id` (`agent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `real_estate_list` (`id`, `code`, `name`, `type_id`, `agent_id`, `status`, `date_created`, `date_updated`) VALUES
(2, '20220200002', 'Sample 102', 2, 1, 1, '2022-02-19 14:12:49', NULL),
(3, '20220200003', 'Sample Only 101', 3, 1, 1, '2022-02-19 16:00:19', '2022-02-19 16:56:21');

-- --------------------------------------------------------
-- Table structure for table `real_estate_amenities`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `real_estate_amenities`;
CREATE TABLE `real_estate_amenities` (
  `id` int(30) NOT NULL AUTO_INCREMENT,
  `real_estate_id` int(30) NOT NULL,
  `amenity_id` int(30) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `real_estate_id` (`real_estate_id`),
  KEY `amenity_id` (`amenity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `real_estate_amenities` (`id`, `real_estate_id`, `amenity_id`) VALUES
(1, 2, 6),
(2, 2, 10),
(3, 2, 5),
(4, 3, 7),
(5, 3, 4),
(6, 3, 6),
(7, 3, 9),
(8, 3, 2),
(9, 3, 10),
(10, 3, 12),
(11, 3, 5),
(12, 3, 3),
(13, 3, 1),
(14, 3, 8),
(15, 3, 11);

-- --------------------------------------------------------
-- Table structure for table `real_estate_meta`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `real_estate_meta`;
CREATE TABLE `real_estate_meta` (
  `id` int(30) NOT NULL AUTO_INCREMENT,
  `real_estate_id` int(30) NOT NULL,
  `meta_field` varchar(255) NOT NULL,
  `meta_value` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `real_estate_id` (`real_estate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `real_estate_meta` (`id`, `real_estate_id`, `meta_field`, `meta_value`) VALUES
(1, 2, 'type', 'Retail or Office'),
(2, 2, 'purpose', 'For Rent'),
(3, 2, 'area', '150 sq. m'),
(4, 2, 'location', 'Over here Street, Here City, Anywhere, 2306'),
(5, 2, 'sale_price', '10000'),
(6, 2, 'coordinates', '66.75804, 128.59442'),
(7, 2, 'description', '&lt;p style=&quot;margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px;&quot;&gt;Integer id sodales elit. Integer rutrum egestas mauris, sit amet volutpat enim egestas at. Vestibulum sit amet placerat leo. Donec accumsan, orci eget scelerisque facilisis, risus nunc rhoncus lorem, nec porttitor ligula massa eget leo. Nulla eget quam id diam rhoncus gravida in eu nunc. Nullam felis enim, lacinia sed turpis sed, pretium blandit libero. Cras ante risus, facilisis quis lobortis ac, imperdiet id nisl.&lt;/p&gt;&lt;p style=&quot;margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px;&quot;&gt;Quisque orci leo, pellentesque a metus sit amet, sagittis ultricies lectus. Vestibulum eros felis, fringilla tincidunt sagittis egestas, tempus ac eros. Donec ullamcorper scelerisque nisi, ac venenatis leo rhoncus ac. Aliquam sed ex a nisl scelerisque commodo. Donec massa dolor, maximus sit amet tellus at, dictum fringilla neque. Praesent est elit, malesuada quis semper eget, viverra at leo. Morbi sed lectus consequat, congue augue eget, rutrum quam. Quisque fermentum id tortor a iaculis. Aliquam erat volutpat. Proin eget ipsum facilisis, placerat velit quis, ultrices urna.&lt;/p&gt;'),
(8, 2, 'thumbnail_path', 'uploads/thumbnails/2.jpg?v=1645251171'),
(9, 3, 'type', 'Single-Family (Detached)'),
(10, 3, 'purpose', 'For Sale'),
(11, 3, 'area', '350 sq. m.'),
(12, 3, 'location', 'Sample'),
(13, 3, 'sale_price', '300000'),
(14, 3, 'coordinates', '10.686511407672004, 122.96388112114987'),
(15, 3, 'description', '&lt;p style=&quot;margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px;&quot;&gt;&lt;span style=&quot;font-size: 0.875rem;&quot;&gt;Sed ac pellentesque arcu, in facilisis neque. Aliquam erat volutpat. Suspendisse imperdiet odio ut neque condimentum, sed hendrerit lectus eleifend. Ut tempor molestie dui, laoreet tristique quam scelerisque at. Nulla elementum viverra ipsum, pharetra congue erat malesuada non. Nam commodo nisl vel sapien tincidunt tempor. Fusce vitae mi at enim convallis efficitur sed in justo.&lt;/span&gt;&lt;br&gt;&lt;/p&gt;&lt;p style=&quot;margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px;&quot;&gt;Aliquam nisi quam, interdum at aliquet vel, vehicula vitae justo. Vestibulum lobortis purus a urna condimentum auctor. Nulla venenatis pellentesque tortor nec viverra. Duis aliquet convallis tellus accumsan egestas. Integer maximus vitae magna a interdum. Nunc laoreet justo fermentum dui iaculis tristique. Nam consectetur vel elit id convallis.&lt;/p&gt;&lt;p style=&quot;margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px;&quot;&gt;Vivamus vestibulum id arcu non pulvinar. Donec ut metus sollicitudin, volutpat dui ut, faucibus turpis. Pellentesque rhoncus, eros sed suscipit dictum, dui risus elementum nisi, ut tempor erat libero a sapien. Nunc diam nibh, lobortis eget eros sit amet, vulputate tristique ipsum. Donec in augue massa. Nam pretium nisi in aliquam vehicula. Nam ligula est, accumsan sagittis sem at, vulputate volutpat nulla.&lt;/p&gt;'),
(16, 3, 'thumbnail_path', 'uploads/thumbnails/3.jpg?v=1645258133');

-- --------------------------------------------------------
-- Table structure for table `system_info`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `system_info`;
CREATE TABLE `system_info` (
  `id` int(30) NOT NULL AUTO_INCREMENT,
  `meta_field` text NOT NULL,
  `meta_value` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `system_info` (`id`, `meta_field`, `meta_value`) VALUES
(1, 'name', 'Real Estate Portal System'),
(6, 'short_name', 'REPS - PHP'),
(11, 'logo', 'uploads/logo-1645233884.jpg?v=1645233884'),
(13, 'user_avatar', 'uploads/user_avatar.jpg'),
(14, 'cover', 'uploads/cover-1645233884.jpg?v=1645233884');

-- --------------------------------------------------------
-- Table structure for table `users`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(50) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(250) NOT NULL,
  `lastname` varchar(250) NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `avatar` text DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 0,
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `users` (`id`, `firstname`, `lastname`, `username`, `password`, `avatar`, `last_login`, `type`, `date_added`, `date_updated`) VALUES
(1, 'Administrator', 'Admin', 'admin', '0192023a7bbd73250516f069df18b500', 'uploads/avatars/1.png?v=1645064505', NULL, 1, '2021-01-20 14:02:37', '2022-02-17 10:21:45');

SET FOREIGN_KEY_CHECKS = 1;
