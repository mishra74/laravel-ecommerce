-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 03, 2025 at 05:23 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `laravel_online_shop`
--

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `status` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `name`, `slug`, `status`, `created_at`, `updated_at`) VALUES
(6, 'Euor Fashion', 'euor-fashion', 1, '2023-05-24 23:17:53', '2025-02-28 10:51:37');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `showHome` enum('Yes','No') NOT NULL DEFAULT 'No',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `image`, `status`, `showHome`, `created_at`, `updated_at`) VALUES
(1, 'Clothes', 'Clothes', NULL, 1, 'No', '2023-04-03 13:03:14', '2023-04-03 13:03:14'),
(2, 'Women\'s Clothes', 'womens-clothes', NULL, 0, 'No', '2023-04-03 13:09:47', '2023-04-03 13:09:47'),
(23, 'Men', 'men', '23-1687381347.jpg', 1, 'Yes', '2023-04-03 13:21:36', '2023-06-21 15:32:28'),
(24, 'Women', 'women', '24-1740758116.jpeg', 1, 'Yes', '2023-04-03 13:21:36', '2025-02-28 10:25:17');

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `name`, `code`, `created_at`, `updated_at`) VALUES
(1, 'United States', 'US', NULL, NULL),
(2, 'Canada', 'CA', NULL, NULL),
(3, 'Afghanistan', 'AF', NULL, NULL),
(4, 'Albania', 'AL', NULL, NULL),
(5, 'Algeria', 'DZ', NULL, NULL),
(6, 'American Samoa', 'AS', NULL, NULL),
(7, 'Andorra', 'AD', NULL, NULL),
(8, 'Angola', 'AO', NULL, NULL),
(9, 'Anguilla', 'AI', NULL, NULL),
(10, 'Antarctica', 'AQ', NULL, NULL),
(11, 'Antigua and/or Barbuda', 'AG', NULL, NULL),
(12, 'Argentina', 'AR', NULL, NULL),
(13, 'Armenia', 'AM', NULL, NULL),
(14, 'Aruba', 'AW', NULL, NULL),
(15, 'Australia', 'AU', NULL, NULL),
(16, 'Austria', 'AT', NULL, NULL),
(17, 'Azerbaijan', 'AZ', NULL, NULL),
(18, 'Bahamas', 'BS', NULL, NULL),
(19, 'Bahrain', 'BH', NULL, NULL),
(20, 'Bangladesh', 'BD', NULL, NULL),
(21, 'Barbados', 'BB', NULL, NULL),
(22, 'Belarus', 'BY', NULL, NULL),
(23, 'Belgium', 'BE', NULL, NULL),
(24, 'Belize', 'BZ', NULL, NULL),
(25, 'Benin', 'BJ', NULL, NULL),
(26, 'Bermuda', 'BM', NULL, NULL),
(27, 'Bhutan', 'BT', NULL, NULL),
(28, 'Bolivia', 'BO', NULL, NULL),
(29, 'Bosnia and Herzegovina', 'BA', NULL, NULL),
(30, 'Botswana', 'BW', NULL, NULL),
(31, 'Bouvet Island', 'BV', NULL, NULL),
(32, 'Brazil', 'BR', NULL, NULL),
(33, 'British lndian Ocean Territory', 'IO', NULL, NULL),
(34, 'Brunei Darussalam', 'BN', NULL, NULL),
(35, 'Bulgaria', 'BG', NULL, NULL),
(36, 'Burkina Faso', 'BF', NULL, NULL),
(37, 'Burundi', 'BI', NULL, NULL),
(38, 'Cambodia', 'KH', NULL, NULL),
(39, 'Cameroon', 'CM', NULL, NULL),
(40, 'Cape Verde', 'CV', NULL, NULL),
(41, 'Cayman Islands', 'KY', NULL, NULL),
(42, 'Central African Republic', 'CF', NULL, NULL),
(43, 'Chad', 'TD', NULL, NULL),
(44, 'Chile', 'CL', NULL, NULL),
(45, 'China', 'CN', NULL, NULL),
(46, 'Christmas Island', 'CX', NULL, NULL),
(47, 'Cocos (Keeling) Islands', 'CC', NULL, NULL),
(48, 'Colombia', 'CO', NULL, NULL),
(49, 'Comoros', 'KM', NULL, NULL),
(50, 'Congo', 'CG', NULL, NULL),
(51, 'Cook Islands', 'CK', NULL, NULL),
(52, 'Costa Rica', 'CR', NULL, NULL),
(53, 'Croatia (Hrvatska)', 'HR', NULL, NULL),
(54, 'Cuba', 'CU', NULL, NULL),
(55, 'Cyprus', 'CY', NULL, NULL),
(56, 'Czech Republic', 'CZ', NULL, NULL),
(57, 'Democratic Republic of Congo', 'CD', NULL, NULL),
(58, 'Denmark', 'DK', NULL, NULL),
(59, 'Djibouti', 'DJ', NULL, NULL),
(60, 'Dominica', 'DM', NULL, NULL),
(61, 'Dominican Republic', 'DO', NULL, NULL),
(62, 'East Timor', 'TP', NULL, NULL),
(63, 'Ecudaor', 'EC', NULL, NULL),
(64, 'Egypt', 'EG', NULL, NULL),
(65, 'El Salvador', 'SV', NULL, NULL),
(66, 'Equatorial Guinea', 'GQ', NULL, NULL),
(67, 'Eritrea', 'ER', NULL, NULL),
(68, 'Estonia', 'EE', NULL, NULL),
(69, 'Ethiopia', 'ET', NULL, NULL),
(70, 'Falkland Islands (Malvinas)', 'FK', NULL, NULL),
(71, 'Faroe Islands', 'FO', NULL, NULL),
(72, 'Fiji', 'FJ', NULL, NULL),
(73, 'Finland', 'FI', NULL, NULL),
(74, 'France', 'FR', NULL, NULL),
(75, 'France, Metropolitan', 'FX', NULL, NULL),
(76, 'French Guiana', 'GF', NULL, NULL),
(77, 'French Polynesia', 'PF', NULL, NULL),
(78, 'French Southern Territories', 'TF', NULL, NULL),
(79, 'Gabon', 'GA', NULL, NULL),
(80, 'Gambia', 'GM', NULL, NULL),
(81, 'Georgia', 'GE', NULL, NULL),
(82, 'Germany', 'DE', NULL, NULL),
(83, 'Ghana', 'GH', NULL, NULL),
(84, 'Gibraltar', 'GI', NULL, NULL),
(85, 'Greece', 'GR', NULL, NULL),
(86, 'Greenland', 'GL', NULL, NULL),
(87, 'Grenada', 'GD', NULL, NULL),
(88, 'Guadeloupe', 'GP', NULL, NULL),
(89, 'Guam', 'GU', NULL, NULL),
(90, 'Guatemala', 'GT', NULL, NULL),
(91, 'Guinea', 'GN', NULL, NULL),
(92, 'Guinea-Bissau', 'GW', NULL, NULL),
(93, 'Guyana', 'GY', NULL, NULL),
(94, 'Haiti', 'HT', NULL, NULL),
(95, 'Heard and Mc Donald Islands', 'HM', NULL, NULL),
(96, 'Honduras', 'HN', NULL, NULL),
(97, 'Hong Kong', 'HK', NULL, NULL),
(98, 'Hungary', 'HU', NULL, NULL),
(99, 'Iceland', 'IS', NULL, NULL),
(100, 'India', 'IN', NULL, NULL),
(101, 'Indonesia', 'ID', NULL, NULL),
(102, 'Iran (Islamic Republic of)', 'IR', NULL, NULL),
(103, 'Iraq', 'IQ', NULL, NULL),
(104, 'Ireland', 'IE', NULL, NULL),
(105, 'Israel', 'IL', NULL, NULL),
(106, 'Italy', 'IT', NULL, NULL),
(107, 'Ivory Coast', 'CI', NULL, NULL),
(108, 'Jamaica', 'JM', NULL, NULL),
(109, 'Japan', 'JP', NULL, NULL),
(110, 'Jordan', 'JO', NULL, NULL),
(111, 'Kazakhstan', 'KZ', NULL, NULL),
(112, 'Kenya', 'KE', NULL, NULL),
(113, 'Kiribati', 'KI', NULL, NULL),
(114, 'Korea, Democratic People\'s Republic of', 'KP', NULL, NULL),
(115, 'Korea, Republic of', 'KR', NULL, NULL),
(116, 'Kuwait', 'KW', NULL, NULL),
(117, 'Kyrgyzstan', 'KG', NULL, NULL),
(118, 'Lao People\'s Democratic Republic', 'LA', NULL, NULL),
(119, 'Latvia', 'LV', NULL, NULL),
(120, 'Lebanon', 'LB', NULL, NULL),
(121, 'Lesotho', 'LS', NULL, NULL),
(122, 'Liberia', 'LR', NULL, NULL),
(123, 'Libyan Arab Jamahiriya', 'LY', NULL, NULL),
(124, 'Liechtenstein', 'LI', NULL, NULL),
(125, 'Lithuania', 'LT', NULL, NULL),
(126, 'Luxembourg', 'LU', NULL, NULL),
(127, 'Macau', 'MO', NULL, NULL),
(128, 'Macedonia', 'MK', NULL, NULL),
(129, 'Madagascar', 'MG', NULL, NULL),
(130, 'Malawi', 'MW', NULL, NULL),
(131, 'Malaysia', 'MY', NULL, NULL),
(132, 'Maldives', 'MV', NULL, NULL),
(133, 'Mali', 'ML', NULL, NULL),
(134, 'Malta', 'MT', NULL, NULL),
(135, 'Marshall Islands', 'MH', NULL, NULL),
(136, 'Martinique', 'MQ', NULL, NULL),
(137, 'Mauritania', 'MR', NULL, NULL),
(138, 'Mauritius', 'MU', NULL, NULL),
(139, 'Mayotte', 'TY', NULL, NULL),
(140, 'Mexico', 'MX', NULL, NULL),
(141, 'Micronesia, Federated States of', 'FM', NULL, NULL),
(142, 'Moldova, Republic of', 'MD', NULL, NULL),
(143, 'Monaco', 'MC', NULL, NULL),
(144, 'Mongolia', 'MN', NULL, NULL),
(145, 'Montserrat', 'MS', NULL, NULL),
(146, 'Morocco', 'MA', NULL, NULL),
(147, 'Mozambique', 'MZ', NULL, NULL),
(148, 'Myanmar', 'MM', NULL, NULL),
(149, 'Namibia', 'NA', NULL, NULL),
(150, 'Nauru', 'NR', NULL, NULL),
(151, 'Nepal', 'NP', NULL, NULL),
(152, 'Netherlands', 'NL', NULL, NULL),
(153, 'Netherlands Antilles', 'AN', NULL, NULL),
(154, 'New Caledonia', 'NC', NULL, NULL),
(155, 'New Zealand', 'NZ', NULL, NULL),
(156, 'Nicaragua', 'NI', NULL, NULL),
(157, 'Niger', 'NE', NULL, NULL),
(158, 'Nigeria', 'NG', NULL, NULL),
(159, 'Niue', 'NU', NULL, NULL),
(160, 'Norfork Island', 'NF', NULL, NULL),
(161, 'Northern Mariana Islands', 'MP', NULL, NULL),
(162, 'Norway', 'NO', NULL, NULL),
(163, 'Oman', 'OM', NULL, NULL),
(164, 'Pakistan', 'PK', NULL, NULL),
(165, 'Palau', 'PW', NULL, NULL),
(166, 'Panama', 'PA', NULL, NULL),
(167, 'Papua New Guinea', 'PG', NULL, NULL),
(168, 'Paraguay', 'PY', NULL, NULL),
(169, 'Peru', 'PE', NULL, NULL),
(170, 'Philippines', 'PH', NULL, NULL),
(171, 'Pitcairn', 'PN', NULL, NULL),
(172, 'Poland', 'PL', NULL, NULL),
(173, 'Portugal', 'PT', NULL, NULL),
(174, 'Puerto Rico', 'PR', NULL, NULL),
(175, 'Qatar', 'QA', NULL, NULL),
(176, 'Republic of South Sudan', 'SS', NULL, NULL),
(177, 'Reunion', 'RE', NULL, NULL),
(178, 'Romania', 'RO', NULL, NULL),
(179, 'Russian Federation', 'RU', NULL, NULL),
(180, 'Rwanda', 'RW', NULL, NULL),
(181, 'Saint Kitts and Nevis', 'KN', NULL, NULL),
(182, 'Saint Lucia', 'LC', NULL, NULL),
(183, 'Saint Vincent and the Grenadines', 'VC', NULL, NULL),
(184, 'Samoa', 'WS', NULL, NULL),
(185, 'San Marino', 'SM', NULL, NULL),
(186, 'Sao Tome and Principe', 'ST', NULL, NULL),
(187, 'Saudi Arabia', 'SA', NULL, NULL),
(188, 'Senegal', 'SN', NULL, NULL),
(189, 'Serbia', 'RS', NULL, NULL),
(190, 'Seychelles', 'SC', NULL, NULL),
(191, 'Sierra Leone', 'SL', NULL, NULL),
(192, 'Singapore', 'SG', NULL, NULL),
(193, 'Slovakia', 'SK', NULL, NULL),
(194, 'Slovenia', 'SI', NULL, NULL),
(195, 'Solomon Islands', 'SB', NULL, NULL),
(196, 'Somalia', 'SO', NULL, NULL),
(197, 'South Africa', 'ZA', NULL, NULL),
(198, 'South Georgia South Sandwich Islands', 'GS', NULL, NULL),
(199, 'Spain', 'ES', NULL, NULL),
(200, 'Sri Lanka', 'LK', NULL, NULL),
(201, 'St. Helena', 'SH', NULL, NULL),
(202, 'St. Pierre and Miquelon', 'PM', NULL, NULL),
(203, 'Sudan', 'SD', NULL, NULL),
(204, 'Suriname', 'SR', NULL, NULL),
(205, 'Svalbarn and Jan Mayen Islands', 'SJ', NULL, NULL),
(206, 'Swaziland', 'SZ', NULL, NULL),
(207, 'Sweden', 'SE', NULL, NULL),
(208, 'Switzerland', 'CH', NULL, NULL),
(209, 'Syrian Arab Republic', 'SY', NULL, NULL),
(210, 'Taiwan', 'TW', NULL, NULL),
(211, 'Tajikistan', 'TJ', NULL, NULL),
(212, 'Tanzania, United Republic of', 'TZ', NULL, NULL),
(213, 'Thailand', 'TH', NULL, NULL),
(214, 'Togo', 'TG', NULL, NULL),
(215, 'Tokelau', 'TK', NULL, NULL),
(216, 'Tonga', 'TO', NULL, NULL),
(217, 'Trinidad and Tobago', 'TT', NULL, NULL),
(218, 'Tunisia', 'TN', NULL, NULL),
(219, 'Turkey', 'TR', NULL, NULL),
(220, 'Turkmenistan', 'TM', NULL, NULL),
(221, 'Turks and Caicos Islands', 'TC', NULL, NULL),
(222, 'Tuvalu', 'TV', NULL, NULL),
(223, 'Uganda', 'UG', NULL, NULL),
(224, 'Ukraine', 'UA', NULL, NULL),
(225, 'United Arab Emirates', 'AE', NULL, NULL),
(226, 'United Kingdom', 'GB', NULL, NULL),
(227, 'United States minor outlying islands', 'UM', NULL, NULL),
(228, 'Uruguay', 'UY', NULL, NULL),
(229, 'Uzbekistan', 'UZ', NULL, NULL),
(230, 'Vanuatu', 'VU', NULL, NULL),
(231, 'Vatican City State', 'VA', NULL, NULL),
(232, 'Venezuela', 'VE', NULL, NULL),
(233, 'Vietnam', 'VN', NULL, NULL),
(234, 'Virgin Islands (British)', 'VG', NULL, NULL),
(235, 'Virgin Islands (U.S.)', 'VI', NULL, NULL),
(236, 'Wallis and Futuna Islands', 'WF', NULL, NULL),
(237, 'Western Sahara', 'EH', NULL, NULL),
(238, 'Yemen', 'YE', NULL, NULL),
(239, 'Yugoslavia', 'YU', NULL, NULL),
(240, 'Zaire', 'ZR', NULL, NULL),
(241, 'Zambia', 'ZM', NULL, NULL),
(242, 'Zimbabwe', 'ZW', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customer_addresses`
--

CREATE TABLE `customer_addresses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mobile` varchar(255) NOT NULL,
  `country_id` bigint(20) UNSIGNED NOT NULL,
  `address` text NOT NULL,
  `apartment` varchar(255) DEFAULT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `zip` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customer_addresses`
--

INSERT INTO `customer_addresses` (`id`, `user_id`, `first_name`, `last_name`, `email`, `mobile`, `country_id`, `address`, `apartment`, `city`, `state`, `zip`, `created_at`, `updated_at`) VALUES
(4, 9, 'ravi kant', 'kant', 'ravikant892123@gmail.com', '08789891918', 100, 'gardanibagh saristabad purvi tola\r\nnear 70feet', NULL, 'PATNA', 'Bihar', '800001', '2025-02-28 11:18:41', '2025-02-28 11:18:41'),
(5, 1, 'ravi KANT', 'kant', 'ravikant892123@gmail.com', '08789891918', 100, 'gardanibagh saristabad purvi tola', NULL, 'PATNA', 'Bihar', '800001', '2025-03-03 01:09:35', '2025-03-03 01:15:05');

-- --------------------------------------------------------

--
-- Table structure for table `discount_coupons`
--

CREATE TABLE `discount_coupons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `max_uses` int(11) DEFAULT NULL,
  `max_uses_user` int(11) DEFAULT NULL,
  `type` enum('percent','fixed') NOT NULL DEFAULT 'fixed',
  `discount_amount` double(10,2) NOT NULL,
  `min_amount` double(10,2) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `starts_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `discount_coupons`
--

INSERT INTO `discount_coupons` (`id`, `code`, `name`, `description`, `max_uses`, `max_uses_user`, `type`, `discount_amount`, `min_amount`, `status`, `starts_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(2, 'EUOR2025', 'India', 'adadasdasd asdasd', 10, 1, 'fixed', 100.00, NULL, 1, '2025-02-28 20:30:35', '2025-03-19 21:30:41', '2023-08-15 03:53:54', '2025-03-03 01:55:30'),
(4, 'IND300', 'india', 'Dummy Data', 20, 300, 'fixed', 100.00, NULL, 1, '2025-03-01 19:30:06', '2025-03-09 23:30:10', '2023-08-16 12:29:15', '2025-03-03 01:57:45'),
(8, 'EUORF2025', 'FIRST USER', NULL, 1, 100, 'fixed', 100.00, 100.00, 1, '2025-03-03 06:58:58', '2025-03-07 20:30:02', '2025-03-03 01:28:42', '2025-03-03 01:29:10');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2023_03_18_184914_alter_users_table', 2),
(7, '2023_04_03_175619_create_categories_table', 3),
(8, '2023_04_04_190135_create_temp_images_table', 4),
(12, '2023_05_15_173635_create_sub_categories_table', 5),
(14, '2023_05_20_171400_create_brands_table', 6),
(18, '2023_05_31_184403_create_products_table', 7),
(19, '2023_05_31_184421_create_product_images_table', 7),
(22, '2023_06_21_191008_alter_categories_table', 8),
(23, '2023_06_21_191617_alter_products_table', 9),
(24, '2023_06_21_193715_alter_sub_categories_table', 10),
(25, '2023_07_05_181537_alter_products_table', 11),
(26, '2023_07_25_044644_alter_users_table', 12),
(27, '2023_07_31_194322_create_countries_table', 13),
(30, '2023_08_05_083454_create_orders_table', 14),
(31, '2023_08_05_083525_create_order_items_table', 14),
(32, '2023_08_05_083557_create_customer_addresses_table', 14),
(34, '2023_08_08_041029_create_shipping_charges_table', 15),
(35, '2023_08_14_175302_create_discount_coupons_table', 16),
(36, '2023_08_22_111821_alter_orders_table', 17),
(37, '2023_08_26_050510_alter_orders_table', 18),
(38, '2023_08_31_080013_alter_orders_table', 19),
(39, '2023_09_03_184050_create_wishlists_table', 20),
(40, '2023_09_12_191828_alter_users_table', 21),
(41, '2023_09_21_043723_create_pages_table', 22),
(42, '2023_11_03_171048_create_product_ratings_table', 23);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `subtotal` double(10,2) NOT NULL,
  `shipping` double(10,2) NOT NULL,
  `coupon_code` varchar(255) DEFAULT NULL,
  `coupon_code_id` int(11) DEFAULT NULL,
  `discount` double(10,2) DEFAULT NULL,
  `grand_total` double(10,2) NOT NULL,
  `payment_status` enum('paid','not paid') NOT NULL DEFAULT 'not paid',
  `status` enum('pending','shipped','delivered','cancelled') NOT NULL DEFAULT 'pending',
  `shipped_date` timestamp NULL DEFAULT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mobile` varchar(255) NOT NULL,
  `country_id` bigint(20) UNSIGNED NOT NULL,
  `address` text NOT NULL,
  `apartment` varchar(255) DEFAULT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `zip` varchar(255) NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `subtotal`, `shipping`, `coupon_code`, `coupon_code_id`, `discount`, `grand_total`, `payment_status`, `status`, `shipped_date`, `first_name`, `last_name`, `email`, `mobile`, `country_id`, `address`, `apartment`, `city`, `state`, `zip`, `notes`, `created_at`, `updated_at`) VALUES
(21, 9, 3498.00, 20.00, '', NULL, 0.00, 3518.00, 'not paid', 'delivered', '2025-02-28 16:51:27', 'ravi kant', 'kant', 'ravikant892123@gmail.com', '08789891918', 100, 'gardanibagh saristabad purvi tola\r\nnear 70feet', NULL, 'PATNA', 'Bihar', '800001', NULL, '2025-02-28 11:19:32', '2025-02-28 11:21:35'),
(22, 1, 5498.00, 20.00, '', NULL, 0.00, 5518.00, 'not paid', 'shipped', '2025-03-18 06:40:07', 'raviKKKKKK', 'kant', 'ravikant892123@gmail.com', '08789891918', 100, 'gardanibagh saristabad purvi tola', NULL, 'PATNA', 'Bihar', '800001', NULL, '2025-03-03 01:09:35', '2025-03-03 01:23:44'),
(23, 1, 999.00, 10.00, '', NULL, 0.00, 1009.00, 'not paid', 'pending', NULL, 'ravi KANT', 'kant', 'ravikant892123@gmail.com', '08789891918', 100, 'gardanibagh saristabad purvi tola', NULL, 'PATNA', 'Bihar', '800001', NULL, '2025-03-03 01:25:15', '2025-03-03 01:25:15');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `qty` int(11) NOT NULL,
  `price` double(10,2) NOT NULL,
  `total` double(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `name`, `qty`, `price`, `total`, `created_at`, `updated_at`) VALUES
(24, 21, 224, 'Chinon Sharara Suit with Handwork Detailing', 1, 2499.00, 2499.00, '2025-02-28 11:19:32', '2025-02-28 11:19:32'),
(25, 21, 220, 'Women\'s Classic Fit 3-Piece Suit', 1, 999.00, 999.00, '2025-02-28 11:19:32', '2025-02-28 11:19:32'),
(26, 22, 224, 'Chinon Sharara Suit with Handwork Detailing', 1, 2499.00, 2499.00, '2025-03-03 01:09:35', '2025-03-03 01:09:35'),
(27, 22, 223, 'Vichitra Silk Indo-Western Dress', 1, 2999.00, 2999.00, '2025-03-03 01:09:35', '2025-03-03 01:09:35'),
(28, 23, 220, 'Women\'s Classic Fit 3-Piece Suit', 1, 999.00, 999.00, '2025-03-03 01:25:15', '2025-03-03 01:25:15');

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `content` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `name`, `slug`, `content`, `created_at`, `updated_at`) VALUES
(3, 'Contact Us', 'contact-us', '<h3 data-start=\"74\" data-end=\"100\"><strong data-start=\"78\" data-end=\"98\">✨ Euor Fashion ✨</strong></h3><p data-start=\"101\" data-end=\"139\"><strong data-start=\"101\" data-end=\"137\">Elevate Your Style with Elegance</strong></p><p data-start=\"141\" data-end=\"374\">Euor Fashion is a premier clothing brand specializing in <strong data-start=\"198\" data-end=\"230\">high-quality women\'s fashion</strong>. With years of expertise in the industry, we are dedicated to bringing you the <strong data-start=\"310\" data-end=\"348\">latest trends and timeless designs</strong> that redefine elegance.</p><hr data-start=\"418\" data-end=\"421\"><h3 data-start=\"423\" data-end=\"446\"><strong data-start=\"427\" data-end=\"444\">&nbsp;&nbsp;</strong><strong data-start=\"427\" data-end=\"444\" style=\"color: inherit; font-family: inherit; font-size: 1.75rem;\">Contact Us</strong></h3><p class=\"\">📍 <strong data-start=\"450\" data-end=\"463\">Location:</strong> Rajnagar Extension, Gzb, Uttar Pradesh – 201017<br data-start=\"517\" data-end=\"520\">📞 <strong data-start=\"523\" data-end=\"533\">Phone:</strong> +91 96500611940<br data-start=\"549\" data-end=\"552\">📧 <strong data-start=\"555\" data-end=\"565\">Email:</strong> <a rel=\"noopener\" data-start=\"566\" data-end=\"619\">euorfashion@gmail.com</a></p><p data-start=\"623\" data-end=\"670\"><span style=\"font-family: Helvetica;\" arial=\"\" black\";\"=\"\">Follow us for the latest fashion updates! 💃✨</span></p><p></p>', '2023-09-23 02:56:31', '2025-02-28 22:18:54'),
(4, 'About Us', 'about-us', '<p style=\"text-align: center; \"><span class=\"about__content--subtitle text__secondary mb-20\" style=\"display: inline-block; transition: var(--transition); color: rgb(66, 109, 71); margin-bottom: 2rem; font-size: 2rem; font-weight: 600; line-height: 2.2rem; font-family: &quot;Courier New&quot;;\">Why Choose us</span></p><p><span class=\"about__content--subtitle text__secondary mb-20\" style=\"display: inline-block; transition: var(--transition); color: rgb(66, 109, 71); margin-bottom: 2rem; font-size: 2rem; font-weight: 600; line-height: 2.2rem; font-family: &quot;Courier New&quot;;\"><br></span><span style=\"font-family: &quot;Courier New&quot;; color: rgb(0, 0, 0); font-size: 3rem; font-weight: 700;\">We do not buy from the open market &amp; traders.</span></p><p class=\"about__content--desc mb-20\" style=\"margin-bottom: 2rem; color: var(--text-gray-color); line-height: 2.8rem; font-family: Jost, sans-serif;\"><span style=\"font-family: &quot;Courier New&quot;;\">Euor Fashion&nbsp;is a leading clothing brand that specializes in producing high-quality women\'s clothing. With years of experience in the fashion industry, we are committed to providing our customers with the latest and most fashionable designs. We have a team of skilled and experienced designers who are passionate about creating unique and stylish pieces that are loved by women all around the world at Euor Fashion&nbsp;, we understand that every customer has unique requirements, and we strive to fulfill them to the best of our ability. While we primarily cater to bulk orders from retailers and we also welcome individual customers who wish to order a single catalog of products. We take pride in our ability to offer a diverse range of clothing options that cater to different tastes and preferences. Our product line includes everything from traditional ethnic wear to modern western outfits, so you can be sure to find something that suits your style. At&nbsp;Euor Fashion, quality is of utmost importance, and we leave no stone unturned in ensuring that our customers receive nothing but the best. We use only the finest materials and fabrics , and our garments undergo rigorous quality checks at every stage of production.</span></p><p class=\"about__content--desc mb-25\" style=\"margin-bottom: 2.5rem; color: var(--text-gray-color); line-height: 2.8rem; font-family: Jost, sans-serif;\"><span style=\"font-family: &quot;Courier New&quot;;\">In addition to our commitment to quality, we also place great emphasis on customer satisfaction. We believe that a satisfied customer is the key to our success, and we strive to exceed their expectations at every step of the way. Whether it\'s providing customer support or delivering orders on time, we go above and beyond to ensure that our customers are happy with their experience. We understand that ordering clothing online can be a daunting task, which is why we have made the process as simple and hassle-free as possible. Our website is easy to navigate, and we offer detailed product descriptions and images to help customers make an informed decision. We also offer secure payment options , Cash on delivery and a hassle-free returns policy, so you can shop with confidence. In conclusion,&nbsp;Euor Fashion is a brand that is dedicated to providing high-quality clothing to customers all around the world. Whether you\'re a retailer or an individual customer, we welcome you to browse our collection and place an order today. With our commitment to quality and customer satisfaction, we\'re confident that you\'ll appreciate EUOR Fashion experience. Get all the latest information on Events, Sales and offers</span></p><p>\r\n\r\n\r\n\r\n</p>', '2023-09-23 02:57:26', '2025-02-28 21:54:31'),
(5, 'Terms & Conditions', 'terms-conditions', '<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. </p><p>It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p><p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.</p><p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.<br></p><p>\r\n\r\n</p>', '2023-09-23 02:58:48', '2023-09-23 12:52:30');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_reset_tokens`
--

INSERT INTO `password_reset_tokens` (`email`, `token`, `created_at`) VALUES
('mark@example.com', 'ZT3kwQ4z640MBRst7NLXfOviNlekOd0bcvQSGcA8CBZpBn0aYD6sdeR8Efvv', '2023-10-05 04:49:44');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `short_description` text DEFAULT NULL,
  `shipping_returns` text DEFAULT NULL,
  `related_products` text DEFAULT NULL,
  `price` double(10,2) NOT NULL,
  `compare_price` double(10,2) DEFAULT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `sub_category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `brand_id` bigint(20) UNSIGNED DEFAULT NULL,
  `is_featured` enum('Yes','No') NOT NULL DEFAULT 'No',
  `sku` varchar(255) NOT NULL,
  `barcode` varchar(255) DEFAULT NULL,
  `track_qty` enum('Yes','No') NOT NULL DEFAULT 'Yes',
  `qty` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `title`, `slug`, `description`, `short_description`, `shipping_returns`, `related_products`, `price`, `compare_price`, `category_id`, `sub_category_id`, `brand_id`, `is_featured`, `sku`, `barcode`, `track_qty`, `qty`, `status`, `created_at`, `updated_at`) VALUES
(20, 'Indulge in Comfort with Premium Men\'s T-Shirts', 'indulge-in-comfort-with-premium-mens-t-shirts', NULL, NULL, NULL, '', 500.00, 999.00, 23, 18, NULL, 'Yes', 'SKU-0042', NULL, 'Yes', 11, 1, '2023-06-14 02:47:49', '2025-02-28 10:41:41'),
(220, 'Women\'s Classic Fit 3-Piece Suit', 'womens-classic-fit-3-piece-suit', '<h3 data-start=\"479\" data-end=\"504\"><strong data-start=\"483\" data-end=\"502\">✨ Key Features:</strong></h3><p data-start=\"506\" data-end=\"1160\">✔ <strong data-start=\"508\" data-end=\"527\">Premium Fabric:</strong> Crafted from a high-quality blend of polyester and viscose for a comfortable, breathable, and wrinkle-resistant finish.<br data-start=\"647\" data-end=\"650\">✔ <strong data-start=\"652\" data-end=\"668\">Classic Fit:</strong> Designed for a sleek yet comfortable fit that enhances your silhouette.<br data-start=\"740\" data-end=\"743\">✔ <strong data-start=\"745\" data-end=\"761\">3-Piece Set:</strong> Includes a tailored blazer, vest, and matching trousers for a complete, polished look.<br data-start=\"848\" data-end=\"851\">✔ <strong data-start=\"853\" data-end=\"874\">Versatile Design:</strong> Suitable for business meetings, weddings, proms, and special occasions.<br data-start=\"946\" data-end=\"949\">✔ <strong data-start=\"951\" data-end=\"981\">Multiple Colors Available:</strong> Choose from timeless black, navy blue, charcoal gray, and more to match your personal style.<br data-start=\"1074\" data-end=\"1077\">✔ <strong data-start=\"1079\" data-end=\"1093\">Easy Care:</strong> Dry clean recommended to maintain the suit’s pristine condition.</p>', '<p>Make a lasting impression with our <strong data-start=\"265\" data-end=\"299\">Men’s Classic Fit 3-Piece Suit</strong>, designed for sophistication and versatility. Whether you\'re dressing for a wedding, business meeting, or formal event, this premium suit ensures you look sharp and confident.</p>', NULL, '', 999.00, 1499.00, 24, 27, 6, 'Yes', 'na', NULL, 'Yes', 8, 1, '2025-02-28 10:47:27', '2025-03-03 01:25:15'),
(221, 'Women\'s Elegant Kaftan Suit – Luxurious', 'womens-elegant-kaftan-suit-luxurious', '<h3 data-start=\"377\" data-end=\"403\"><strong data-start=\"381\" data-end=\"401\">🌟 Key Features:</strong></h3><p data-start=\"405\" data-end=\"1192\">✔ <strong data-start=\"407\" data-end=\"426\">Premium Fabric:</strong> Made from high-quality chiffon, cotton, or satin for a soft, breathable, and flowy feel.<br data-start=\"515\" data-end=\"518\">✔ <strong data-start=\"520\" data-end=\"536\">Relaxed Fit:</strong> Loose and airy design provides comfort while maintaining a stylish, graceful look.<br data-start=\"619\" data-end=\"622\">✔ <strong data-start=\"624\" data-end=\"653\">Intricate Embellishments:</strong> Beautiful embroidery, beading, or sequin details enhance the elegance of the outfit.<br data-start=\"738\" data-end=\"741\">✔ <strong data-start=\"743\" data-end=\"762\">Versatile Wear:</strong> Ideal for weddings, Eid, Ramadan, evening parties, and everyday wear.<br data-start=\"832\" data-end=\"835\">✔ <strong data-start=\"837\" data-end=\"855\">Easy to Style:</strong> Pair with statement jewelry and heels for a formal look or sandals for a casual outing.<br data-start=\"943\" data-end=\"946\">✔ <strong data-start=\"948\" data-end=\"991\">Available in Multiple Colors &amp; Designs:</strong> Choose from classic neutrals, vibrant hues, and elegant prints to match your style.<br data-start=\"1075\" data-end=\"1078\">✔ <strong data-start=\"1080\" data-end=\"1106\">Sizes for Every Woman:</strong> Available in standard and plus sizes to ensure a flattering fit for all body types.</p><h3 data-start=\"1194\" data-end=\"1236\"><strong data-start=\"1198\" data-end=\"1234\">🌿 Effortless Elegance &amp; Comfort</strong></h3><p data-start=\"1237\" data-end=\"1462\">The <strong data-start=\"1241\" data-end=\"1256\">Kaftan Suit</strong> is designed to provide effortless beauty without compromising comfort. Whether you\'re dressing up for a special event or looking for a stylish everyday outfit, this suit ensures you stand out with poise.</p>', '<h2 data-start=\"85\" data-end=\"128\"><strong data-start=\"88\" data-end=\"126\">✨ Graceful, Stylish, &amp; Comfortable</strong></h2><p data-start=\"130\" data-end=\"375\">Step into elegance with our <strong data-start=\"158\" data-end=\"181\">Women\'s Kaftan Suit</strong>, designed for women who appreciate modest fashion with a modern touch. Crafted for comfort and sophistication, this suit is perfect for formal events, casual outings, and cultural gatherings.</p>', '<h1 data-start=\"106\" data-end=\"141\"><strong data-start=\"108\" data-end=\"139\">📦 Shipping &amp; Return Policy</strong></h1><h3 data-start=\"143\" data-end=\"177\"><strong data-start=\"147\" data-end=\"175\">🚚 Shipping Information:</strong></h3><p data-start=\"178\" data-end=\"551\">✔ <strong data-start=\"180\" data-end=\"209\">Fast &amp; Reliable Delivery:</strong> Orders are processed within <strong data-start=\"238\" data-end=\"253\">24-48 hours</strong> and shipped via trusted carriers.<br data-start=\"287\" data-end=\"290\">✔ <strong data-start=\"292\" data-end=\"320\">Estimated Delivery Time:</strong> Standard shipping takes <strong data-start=\"345\" data-end=\"366\">5-7 business days</strong>, while expedited shipping takes <strong data-start=\"399\" data-end=\"420\">2-3 business days</strong> (varies by location).<br data-start=\"442\" data-end=\"445\">✔ <strong data-start=\"447\" data-end=\"474\">International Shipping:</strong> Available to select countries. Shipping costs and delivery times may vary.</p><h3 data-start=\"553\" data-end=\"591\"><strong data-start=\"557\" data-end=\"589\">🔄 Easy Returns &amp; Exchanges:</strong></h3><p data-start=\"592\" data-end=\"1022\">✔ <strong data-start=\"594\" data-end=\"618\">Hassle-Free Returns:</strong> If you\'re not satisfied, you can return the item within <strong data-start=\"675\" data-end=\"686\">30 days</strong> of delivery.<br data-start=\"699\" data-end=\"702\">✔ <strong data-start=\"704\" data-end=\"725\">Return Condition:</strong> The product must be <strong data-start=\"746\" data-end=\"816\">unused, unwashed, and in its original packaging with tags attached</strong>.<br data-start=\"817\" data-end=\"820\">✔ <strong data-start=\"822\" data-end=\"847\">Free Return Shipping:</strong> Available for eligible returns under Amazon’s return policy.<br data-start=\"908\" data-end=\"911\">✔ <strong data-start=\"913\" data-end=\"933\">Exchange Option:</strong> If the size or color isn’t right, you can request an exchange for a different variant.</p><h3 data-start=\"1024\" data-end=\"1052\"><strong data-start=\"1028\" data-end=\"1050\">❗ Important Notes:</strong></h3><ul data-start=\"1053\" data-end=\"1286\"><li data-start=\"1053\" data-end=\"1128\">Refunds are processed once the returned item is received and inspected.</li><li data-start=\"1129\" data-end=\"1197\">Custom-made or final sale items may not be eligible for returns.</li><li data-start=\"1198\" data-end=\"1286\">If you receive a damaged or incorrect item, contact us immediately for a resolution.</li></ul><p data-start=\"1288\" data-end=\"1362\">📩 <strong data-start=\"1291\" data-end=\"1305\">Need help?</strong> Reach out to our customer support team for assistance.</p>', '', 999.00, 1499.00, 24, 26, 6, 'No', 'sku-1', NULL, 'Yes', 10, 1, '2025-02-28 10:55:17', '2025-02-28 10:55:17'),
(222, 'Women\'s Fusion Dress blend traditional elegance', 'womens-fusion-dress-blend-traditional-elegance', '<h3 data-start=\"398\" data-end=\"424\"><strong data-start=\"402\" data-end=\"422\">🌟 Key Features:</strong></h3><p data-start=\"426\" data-end=\"1085\">✔ <strong data-start=\"428\" data-end=\"447\">Premium Fabric:</strong> Crafted from high-quality cotton, chiffon, silk, or georgette for a soft and breathable feel.<br data-start=\"541\" data-end=\"544\">✔ <strong data-start=\"546\" data-end=\"564\">Unique Design:</strong> A stylish mix of ethnic patterns and contemporary cuts for a trendy yet elegant look.<br data-start=\"650\" data-end=\"653\">✔ <strong data-start=\"655\" data-end=\"674\">Flattering Fit:</strong> Designed to complement all body types with flowy silhouettes, fitted bodices, and asymmetrical hems.<br data-start=\"775\" data-end=\"778\">✔ <strong data-start=\"780\" data-end=\"802\">Versatile Styling:</strong> Perfect for weddings, festivals, parties, and casual gatherings.<br data-start=\"867\" data-end=\"870\">✔ <strong data-start=\"872\" data-end=\"894\">Intricate Details:</strong> Features embroidery, prints, or embellishments for an exquisite finish.<br data-start=\"966\" data-end=\"969\">✔ <strong data-start=\"971\" data-end=\"1012\">Available in Multiple Colors &amp; Sizes:</strong> Choose from classic neutrals, vibrant hues, and eye-catching patterns.</p><h3 data-start=\"1087\" data-end=\"1129\"><strong data-start=\"1091\" data-end=\"1127\">🌿 Effortless Elegance &amp; Comfort</strong></h3><p data-start=\"1130\" data-end=\"1375\">This <strong data-start=\"1135\" data-end=\"1151\">Fusion Dress</strong> offers the perfect balance of comfort and style, making it an essential addition to every woman’s wardrobe. Whether paired with heels for a formal look or flats for a relaxed vibe, it’s a statement piece for any occasion.</p>', '<h2 data-start=\"79\" data-end=\"132\"><strong data-start=\"82\" data-end=\"130\">✨ Contemporary Fashion with a Cultural Touch</strong></h2><p data-start=\"134\" data-end=\"396\">Embrace the beauty of fusion fashion with our <strong data-start=\"180\" data-end=\"204\">Women\'s Fusion Dress</strong>, designed to blend traditional elegance with modern trends. Whether you\'re attending a festive celebration, wedding, or casual outing, this dress brings sophistication and comfort together.</p>', '<h1 data-start=\"106\" data-end=\"141\"><strong data-start=\"108\" data-end=\"139\">📦 Shipping &amp; Return Policy</strong></h1><h3 data-start=\"143\" data-end=\"177\"><strong data-start=\"147\" data-end=\"175\">🚚 Shipping Information:</strong></h3><p data-start=\"178\" data-end=\"551\">✔ <strong data-start=\"180\" data-end=\"209\">Fast &amp; Reliable Delivery:</strong> Orders are processed within <strong data-start=\"238\" data-end=\"253\">24-48 hours</strong> and shipped via trusted carriers.<br data-start=\"287\" data-end=\"290\">✔ <strong data-start=\"292\" data-end=\"320\">Estimated Delivery Time:</strong> Standard shipping takes <strong data-start=\"345\" data-end=\"366\">5-7 business days</strong>, while expedited shipping takes <strong data-start=\"399\" data-end=\"420\">2-3 business days</strong> (varies by location).<br data-start=\"442\" data-end=\"445\">✔ <strong data-start=\"447\" data-end=\"474\">International Shipping:</strong> Available to select countries. Shipping costs and delivery times may vary.</p><h3 data-start=\"553\" data-end=\"591\"><strong data-start=\"557\" data-end=\"589\">🔄 Easy Returns &amp; Exchanges:</strong></h3><p data-start=\"592\" data-end=\"1022\">✔ <strong data-start=\"594\" data-end=\"618\">Hassle-Free Returns:</strong> If you\'re not satisfied, you can return the item within <strong data-start=\"675\" data-end=\"686\">30 days</strong> of delivery.<br data-start=\"699\" data-end=\"702\">✔ <strong data-start=\"704\" data-end=\"725\">Return Condition:</strong> The product must be <strong data-start=\"746\" data-end=\"816\">unused, unwashed, and in its original packaging with tags attached</strong>.<br data-start=\"817\" data-end=\"820\">✔ <strong data-start=\"822\" data-end=\"847\">Free Return Shipping:</strong> Available for eligible returns under Amazon’s return policy.<br data-start=\"908\" data-end=\"911\">✔ <strong data-start=\"913\" data-end=\"933\">Exchange Option:</strong> If the size or color isn’t right, you can request an exchange for a different variant.</p><h3 data-start=\"1024\" data-end=\"1052\"><strong data-start=\"1028\" data-end=\"1050\">❗ Important Notes:</strong></h3><ul data-start=\"1053\" data-end=\"1286\"><li data-start=\"1053\" data-end=\"1128\">Refunds are processed once the returned item is received and inspected.</li><li data-start=\"1129\" data-end=\"1197\">Custom-made or final sale items may not be eligible for returns.</li><li data-start=\"1198\" data-end=\"1286\">If you receive a damaged or incorrect item, contact us immediately for a resolution.</li></ul><p data-start=\"1288\" data-end=\"1362\">📩 <strong data-start=\"1291\" data-end=\"1305\">Need help?</strong> Reach out to our customer support team for assistance.</p>', '', 1999.00, 2499.00, 24, 28, 6, 'No', 'sku-3', NULL, 'Yes', 10, 1, '2025-02-28 11:00:33', '2025-02-28 11:12:34'),
(223, 'Vichitra Silk Indo-Western Dress', 'vichitra-silk-indo-western-dress', '<h3 data-start=\"426\" data-end=\"452\"><strong data-start=\"430\" data-end=\"450\">🌟 Key Features:</strong></h3><p data-start=\"454\" data-end=\"1128\">✔ <strong data-start=\"456\" data-end=\"489\">Premium Vichitra Silk Fabric:</strong> Known for its soft texture, rich sheen, and elegant drape.<br data-start=\"548\" data-end=\"551\">✔ <strong data-start=\"553\" data-end=\"584\">Indo-Western Fusion Design:</strong> A blend of traditional Indian aesthetics with modern silhouettes.<br data-start=\"650\" data-end=\"653\">✔ <strong data-start=\"655\" data-end=\"684\">Intricate Embellishments:</strong> Features delicate embroidery, zari work, sequins, or stone detailing for a luxurious touch.<br data-start=\"776\" data-end=\"779\">✔ <strong data-start=\"781\" data-end=\"807\">Flattering Silhouette:</strong> Designed with flowy, asymmetrical, or layered patterns to enhance your style.<br data-start=\"885\" data-end=\"888\">✔ <strong data-start=\"890\" data-end=\"912\">Versatile Styling:</strong> Can be paired with statement jewelry, heels, or ethnic footwear for different looks.<br data-start=\"997\" data-end=\"1000\">✔ <strong data-start=\"1002\" data-end=\"1043\">Available in Multiple Colors &amp; Sizes:</strong> From classic neutrals to vibrant festive hues, there’s a shade for every occasion.</p><h3 data-start=\"1130\" data-end=\"1182\"><strong data-start=\"1134\" data-end=\"1180\">🌿 Grace, Comfort &amp; Elegance in One Outfit</strong></h3><p data-start=\"1183\" data-end=\"1430\">The <strong data-start=\"1187\" data-end=\"1223\">Vichitra Silk Indo-Western Dress</strong> is designed for modern women who love to embrace cultural heritage with a contemporary twist. Whether it\'s a festive gathering or a stylish evening event, this dress ensures you stand out with confidence.</p><h3 data-start=\"1432\" data-end=\"1479\"><strong data-start=\"1436\" data-end=\"1477\">💖 Why Choose Our Indo-Western Dress?</strong></h3><p data-start=\"1480\" data-end=\"1640\">✔ Exquisite craftsmanship with high-quality fabric<br data-start=\"1530\" data-end=\"1533\">✔ Comfortable yet stylish fit for all body types<br data-start=\"1581\" data-end=\"1584\">✔ Perfect for weddings, parties, and special occasions</p><p data-start=\"1642\" data-end=\"1716\">🎀 <strong data-start=\"1645\" data-end=\"1714\">Upgrade your wardrobe with this elegant fusion piece – Order Now!</strong></p>', '<h2 data-start=\"93\" data-end=\"134\"><strong data-start=\"96\" data-end=\"132\">✨ Regal Look with a Modern Touch</strong></h2><p data-start=\"136\" data-end=\"424\">Step into luxury with our <strong data-start=\"162\" data-end=\"198\">Vichitra Silk Indo-Western Dress</strong>, a stunning fusion of ethnic charm and contemporary fashion. Crafted from premium <strong data-start=\"281\" data-end=\"298\">Vichitra silk</strong>, this dress exudes sophistication, making it perfect for festive celebrations, weddings, receptions, and special occasions.</p>', '<main style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; background-color: rgb(241, 241, 241); color: rgb(0, 29, 61); font-family: Poppins; outline: none !important;\"><section class=\"section-7 pt-3 mb-3\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; outline: none !important;\"><div class=\"container\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; width: 1140px; padding-right: var(--bs-gutter-x, 0.75rem); padding-left: var(--bs-gutter-x, 0.75rem); outline: none !important;\"><div class=\"row \" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; --bs-gutter-x: 1.5rem; --bs-gutter-y: 0; margin-top: calc(-1 * var(--bs-gutter-y)); margin-right: calc(-0.5 * var(--bs-gutter-x)); margin-left: calc(-0.5 * var(--bs-gutter-x)); outline: none !important;\"><div class=\"col-md-12 mt-5\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; flex-basis: auto; width: 1140px; padding-right: calc(var(--bs-gutter-x) * 0.5); padding-left: calc(var(--bs-gutter-x) * 0.5); outline: none !important;\"><div class=\"bg-light\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; --bs-bg-opacity: 1; background-color: rgb(241, 241, 241) !important; outline: none !important;\"><div class=\"tab-content\" id=\"myTabContent\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; padding: 30px; background-color: rgb(255, 255, 255); line-height: 1.8; outline: none !important;\"><div class=\"tab-pane fade active show\" id=\"shipping\" role=\"tabpanel\" aria-labelledby=\"shipping-tab\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility;\"><h3 data-start=\"143\" data-end=\"177\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; margin-right: 0px; margin-bottom: 0px; margin-left: 0px;\"><span data-start=\"147\" data-end=\"175\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">🚚 Shipping Information:</span></h3><p data-start=\"178\" data-end=\"551\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; line-height: 1.5;\">✔&nbsp;<span data-start=\"180\" data-end=\"209\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">Fast &amp; Reliable Delivery:</span>&nbsp;Orders are processed within&nbsp;<span data-start=\"238\" data-end=\"253\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">24-48 hours</span>&nbsp;and shipped via trusted carriers.<br data-start=\"287\" data-end=\"290\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility;\">✔&nbsp;<span data-start=\"292\" data-end=\"320\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">Estimated Delivery Time:</span>&nbsp;Standard shipping takes&nbsp;<span data-start=\"345\" data-end=\"366\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">5-7 business days</span>, while expedited shipping takes&nbsp;<span data-start=\"399\" data-end=\"420\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">2-3 business days</span>&nbsp;(varies by location).<br data-start=\"442\" data-end=\"445\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility;\">✔&nbsp;<span data-start=\"447\" data-end=\"474\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">International Shipping:</span>&nbsp;Available to select countries. Shipping costs and delivery times may vary.</p><h3 data-start=\"553\" data-end=\"591\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; margin-right: 0px; margin-bottom: 0px; margin-left: 0px;\"><span data-start=\"557\" data-end=\"589\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">🔄 Easy Returns &amp; Exchanges:</span></h3><p data-start=\"592\" data-end=\"1022\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; line-height: 1.5;\">✔&nbsp;<span data-start=\"594\" data-end=\"618\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">Hassle-Free Returns:</span>&nbsp;If you\'re not satisfied, you can return the item within&nbsp;<span data-start=\"675\" data-end=\"686\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">30 days</span>&nbsp;of delivery.<br data-start=\"699\" data-end=\"702\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility;\">✔&nbsp;<span data-start=\"704\" data-end=\"725\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">Return Condition:</span>&nbsp;The product must be&nbsp;<span data-start=\"746\" data-end=\"816\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">unused, unwashed, and in its original packaging with tags attached</span>.<br data-start=\"817\" data-end=\"820\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility;\">✔&nbsp;<span data-start=\"822\" data-end=\"847\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">Free Return Shipping:</span>&nbsp;Available for eligible returns under Amazon’s return policy.<br data-start=\"908\" data-end=\"911\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility;\">✔&nbsp;<span data-start=\"913\" data-end=\"933\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">Exchange Option:</span>&nbsp;If the size or color isn’t right, you can request an exchange for a different variant.</p><h3 data-start=\"1024\" data-end=\"1052\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; margin-right: 0px; margin-bottom: 0px; margin-left: 0px;\"><span data-start=\"1028\" data-end=\"1050\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">❗ Important Notes:</span></h3><ul data-start=\"1053\" data-end=\"1286\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; padding: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px;\"><li data-start=\"1053\" data-end=\"1128\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; list-style: none;\">Refunds are processed once the returned item is received and inspected.</li><li data-start=\"1129\" data-end=\"1197\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; list-style: none;\">Custom-made or final sale items may not be eligible for returns.</li><li data-start=\"1198\" data-end=\"1286\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; list-style: none;\">If you receive a damaged or incorrect item, contact us immediately for a resolution.</li></ul><p data-start=\"1288\" data-end=\"1362\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; line-height: 1.5;\">📩&nbsp;<span data-start=\"1291\" data-end=\"1305\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">Need help?</span>&nbsp;Reach out to our customer support team for assistance.</p></div></div></div></div></div></div></section></main>', '', 2999.00, 3999.00, 24, 29, 6, 'Yes', 'sku-5', NULL, 'Yes', 9, 1, '2025-02-28 11:06:08', '2025-03-03 01:09:35'),
(224, 'Chinon Sharara Suit with Handwork Detailing', 'chinon-sharara-suit-with-handwork-detailing', '<h3 data-start=\"460\" data-end=\"486\"><strong data-start=\"464\" data-end=\"484\">🌟 Key Features:</strong></h3><p data-start=\"488\" data-end=\"1150\">✔ <strong data-start=\"490\" data-end=\"516\">Premium Chinon Fabric:</strong> Lightweight, flowy, and soft for a comfortable yet regal feel.<br data-start=\"579\" data-end=\"582\">✔ <strong data-start=\"584\" data-end=\"617\">Exquisite Handwork Detailing:</strong> Features delicate embroidery, sequins, zari, or beadwork for a rich and elegant look.<br data-start=\"703\" data-end=\"706\">✔ <strong data-start=\"708\" data-end=\"735\">Classic Sharara Design:</strong> A flattering silhouette with a stylish flared sharara pant for effortless grace.<br data-start=\"816\" data-end=\"819\">✔ <strong data-start=\"821\" data-end=\"841\">Elegant Dupatta:</strong> Comes with a beautifully embellished or embroidered dupatta to complete the look.<br data-start=\"923\" data-end=\"926\">✔ <strong data-start=\"928\" data-end=\"959\">Perfect for Every Occasion:</strong> Ideal for weddings, receptions, parties, and festive celebrations like Diwali &amp; Eid.<br data-start=\"1044\" data-end=\"1047\">✔ <strong data-start=\"1049\" data-end=\"1081\">Available in Multiple Sizes:</strong> <strong data-start=\"1082\" data-end=\"1099\">M, L, XL, 2XL</strong> – Designed for a perfect fit for all body types.</p><h3 data-start=\"1152\" data-end=\"1205\"><strong data-start=\"1156\" data-end=\"1203\">🌿 Grace, Comfort &amp; Tradition in One Outfit</strong></h3><p data-start=\"1206\" data-end=\"1381\">This <strong data-start=\"1211\" data-end=\"1234\">Chinon Sharara Suit</strong> blends comfort and grandeur, making it a must-have for ethnic wear lovers. Pair it with statement jewelry and heels for a complete festive look.</p><h3 data-start=\"1383\" data-end=\"1424\"><strong data-start=\"1387\" data-end=\"1422\">💖 Why Choose Our Sharara Suit?</strong></h3><p data-start=\"1425\" data-end=\"1578\">✔ High-quality craftsmanship with intricate handwork<br data-start=\"1477\" data-end=\"1480\">✔ Comfortable yet elegant for long-hour wear<br data-start=\"1524\" data-end=\"1527\">✔ Available in stunning colors and multiple sizes</p><p data-start=\"1580\" data-end=\"1670\">🎀 <strong data-start=\"1583\" data-end=\"1668\">Upgrade your ethnic wardrobe with this luxurious Chinon Sharara Suit – Order Now!</strong></p>', '<h2 data-start=\"86\" data-end=\"144\"><strong data-start=\"89\" data-end=\"142\">✨ Luxurious, Stylish &amp; Perfect for Every Occasion</strong></h2><p data-start=\"146\" data-end=\"458\">Step into elegance with our <strong data-start=\"174\" data-end=\"197\">Chinon Sharara Suit</strong>, crafted for women who love traditional fashion with a contemporary touch. Made from premium <strong data-start=\"291\" data-end=\"308\">Chinon fabric</strong>, this suit is adorned with exquisite <strong data-start=\"346\" data-end=\"368\">handwork detailing</strong>, making it a perfect choice for weddings, festive celebrations, and special gatherings.</p>', '<h3 data-start=\"143\" data-end=\"177\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; color: rgb(0, 29, 61); font-family: Poppins;\"><span data-start=\"147\" data-end=\"175\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">🚚 Shipping Information:</span></h3><p data-start=\"178\" data-end=\"551\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-family: Poppins; line-height: 1.5; color: rgb(0, 29, 61);\">✔&nbsp;<span data-start=\"180\" data-end=\"209\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">Fast &amp; Reliable Delivery:</span>&nbsp;Orders are processed within&nbsp;<span data-start=\"238\" data-end=\"253\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">24-48 hours</span>&nbsp;and shipped via trusted carriers.<br data-start=\"287\" data-end=\"290\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility;\">✔&nbsp;<span data-start=\"292\" data-end=\"320\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">Estimated Delivery Time:</span>&nbsp;Standard shipping takes&nbsp;<span data-start=\"345\" data-end=\"366\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">5-7 business days</span>, while expedited shipping takes&nbsp;<span data-start=\"399\" data-end=\"420\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">2-3 business days</span>&nbsp;(varies by location).<br data-start=\"442\" data-end=\"445\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility;\">✔&nbsp;<span data-start=\"447\" data-end=\"474\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">International Shipping:</span>&nbsp;Available to select countries. Shipping costs and delivery times may vary.</p><h3 data-start=\"553\" data-end=\"591\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; color: rgb(0, 29, 61); font-family: Poppins;\"><span data-start=\"557\" data-end=\"589\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">🔄 Easy Returns &amp; Exchanges:</span></h3><p data-start=\"592\" data-end=\"1022\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-family: Poppins; line-height: 1.5; color: rgb(0, 29, 61);\">✔&nbsp;<span data-start=\"594\" data-end=\"618\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">Hassle-Free Returns:</span>&nbsp;If you\'re not satisfied, you can return the item within&nbsp;<span data-start=\"675\" data-end=\"686\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">30 days</span>&nbsp;of delivery.<br data-start=\"699\" data-end=\"702\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility;\">✔&nbsp;<span data-start=\"704\" data-end=\"725\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">Return Condition:</span>&nbsp;The product must be&nbsp;<span data-start=\"746\" data-end=\"816\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">unused, unwashed, and in its original packaging with tags attached</span>.<br data-start=\"817\" data-end=\"820\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility;\">✔&nbsp;<span data-start=\"822\" data-end=\"847\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">Free Return Shipping:</span>&nbsp;Available for eligible returns under Amazon’s return policy.<br data-start=\"908\" data-end=\"911\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility;\">✔&nbsp;<span data-start=\"913\" data-end=\"933\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">Exchange Option:</span>&nbsp;If the size or color isn’t right, you can request an exchange for a different variant.</p><h3 data-start=\"1024\" data-end=\"1052\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; color: rgb(0, 29, 61); font-family: Poppins;\"><span data-start=\"1028\" data-end=\"1050\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">❗ Important Notes:</span></h3><ul data-start=\"1053\" data-end=\"1286\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; padding: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; color: rgb(0, 29, 61); font-family: Poppins;\"><li data-start=\"1053\" data-end=\"1128\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; list-style: none;\">Refunds are processed once the returned item is received and inspected.</li><li data-start=\"1129\" data-end=\"1197\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; list-style: none;\">Custom-made or final sale items may not be eligible for returns.</li><li data-start=\"1198\" data-end=\"1286\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; list-style: none;\">If you receive a damaged or incorrect item, contact us immediately for a resolution.</li></ul><p data-start=\"1288\" data-end=\"1362\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-family: Poppins; line-height: 1.5; color: rgb(0, 29, 61); outline: none !important;\">📩&nbsp;<span data-start=\"1291\" data-end=\"1305\" style=\"vertical-align: baseline; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased; text-rendering: optimizelegibility; font-weight: bolder;\">Need help?</span>&nbsp;Reach out to our customer support team for assistance.</p>', '', 2499.00, 3999.00, 24, 25, 6, 'Yes', 'sku-6', NULL, 'Yes', 8, 1, '2025-02-28 11:09:33', '2025-03-03 01:09:35'),
(225, 'Linen fabric suit with kantha work', 'linen-fabric-suit-with-kantha-work', '<h3 data-start=\"482\" data-end=\"508\"><strong data-start=\"486\" data-end=\"506\">🌟 Key Features:</strong></h3><p data-start=\"510\" data-end=\"1096\">✔ <strong data-start=\"512\" data-end=\"537\">Premium Linen Fabric:</strong> Lightweight, breathable, and soft for all-day comfort.<br data-start=\"592\" data-end=\"595\">✔ <strong data-start=\"597\" data-end=\"627\">Authentic Kantha Handwork:</strong> Beautiful running stitch embroidery, adding a rustic and elegant charm.<br data-start=\"699\" data-end=\"702\">✔ <strong data-start=\"704\" data-end=\"732\">Minimal Yet Chic Design:</strong> Subtle yet intricate threadwork enhances the suit’s sophistication.<br data-start=\"800\" data-end=\"803\">✔ <strong data-start=\"805\" data-end=\"829\">Versatile &amp; Stylish:</strong> Ideal for office wear, festive occasions, and casual gatherings.<br data-start=\"894\" data-end=\"897\">✔ <strong data-start=\"899\" data-end=\"919\">Comfortable Fit:</strong> Designed for all-day ease with a flattering silhouette.<br data-start=\"975\" data-end=\"978\">✔ <strong data-start=\"980\" data-end=\"1021\">Available in Multiple Colors &amp; Sizes:</strong> Choose from earthy tones, pastels, and vibrant hues to match your style.</p><h3 data-start=\"1098\" data-end=\"1147\"><strong data-start=\"1102\" data-end=\"1145\">🌿 Handmade Artistry &amp; Everyday Comfort</strong></h3><p data-start=\"1148\" data-end=\"1308\">Kantha embroidery adds a unique handcrafted touch, making each suit a work of art. Pair it with oxidized jewelry, juttis, or heels for a complete ethnic look.</p><h3 data-start=\"1310\" data-end=\"1366\"><strong data-start=\"1314\" data-end=\"1364\">💖 Why Choose Our Linen Suit with Kantha Work?</strong></h3><p data-start=\"1367\" data-end=\"1520\">✔ Handcrafted embroidery for an exclusive look<br data-start=\"1413\" data-end=\"1416\">✔ Breathable and comfortable fabric for every season<br data-start=\"1468\" data-end=\"1471\">✔ Perfect for both casual and festive occasions</p><p data-start=\"1522\" data-end=\"1599\">🎀 <strong data-start=\"1525\" data-end=\"1597\">Upgrade your wardrobe with this handcrafted masterpiece – Order Now!</strong></p>', '<h2 data-start=\"77\" data-end=\"140\"><strong data-start=\"80\" data-end=\"138\">✨ Timeless Elegance with Handcrafted Kantha Embroidery</strong></h2><p><h3 data-start=\"482\" data-end=\"508\"></h3></p><p data-start=\"142\" data-end=\"480\">Experience the beauty of traditional craftsmanship with our <strong data-start=\"202\" data-end=\"240\">Linen Fabric Suit with Kantha Work</strong>. Designed for women who appreciate artisanal embroidery and breathable fabrics, this suit blends elegance with comfort. Perfect for casual outings, festive gatherings, office wear, or cultural events, it’s a must-have for every wardrobe.</p>', NULL, '', 1999.00, 2999.00, 24, 30, 6, 'No', 'sku-7', NULL, 'Yes', 10, 1, '2025-02-28 11:39:12', '2025-02-28 11:39:12');

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `image` varchar(255) NOT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_images`
--

INSERT INTO `product_images` (`id`, `product_id`, `image`, `sort_order`, `created_at`, `updated_at`) VALUES
(42, 20, '20-42-1740758964.jpeg', NULL, '2025-02-28 10:39:24', '2025-02-28 10:39:24'),
(43, 20, '20-43-1740758974.jpeg', NULL, '2025-02-28 10:39:34', '2025-02-28 10:39:34'),
(44, 20, '20-44-1740758984.jpeg', NULL, '2025-02-28 10:39:44', '2025-02-28 10:39:44'),
(48, 221, '221-48-1740759917.jpeg', NULL, '2025-02-28 10:55:17', '2025-02-28 10:55:17'),
(49, 221, '221-49-1740759918.jpeg', NULL, '2025-02-28 10:55:18', '2025-02-28 10:55:18'),
(50, 221, '221-50-1740759918.jpeg', NULL, '2025-02-28 10:55:18', '2025-02-28 10:55:18'),
(51, 220, '220-51-1740760044.jpeg', NULL, '2025-02-28 10:57:24', '2025-02-28 10:57:24'),
(52, 220, '220-52-1740760051.jpeg', NULL, '2025-02-28 10:57:31', '2025-02-28 10:57:31'),
(53, 222, '222-53-1740760233.jpeg', NULL, '2025-02-28 11:00:33', '2025-02-28 11:00:33'),
(54, 222, '222-54-1740760234.jpeg', NULL, '2025-02-28 11:00:34', '2025-02-28 11:00:34'),
(55, 223, '223-55-1740760568.jpeg', NULL, '2025-02-28 11:06:08', '2025-02-28 11:06:08'),
(56, 223, '223-56-1740760568.jpeg', NULL, '2025-02-28 11:06:08', '2025-02-28 11:06:08'),
(57, 223, '223-57-1740760569.jpeg', NULL, '2025-02-28 11:06:09', '2025-02-28 11:06:09'),
(58, 224, '224-58-1740760773.jpeg', NULL, '2025-02-28 11:09:33', '2025-02-28 11:09:33'),
(59, 224, '224-59-1740760774.jpeg', NULL, '2025-02-28 11:09:34', '2025-02-28 11:09:34'),
(60, 224, '224-60-1740760775.jpeg', NULL, '2025-02-28 11:09:35', '2025-02-28 11:09:35'),
(61, 225, '225-61-1740762552.jpeg', NULL, '2025-02-28 11:39:12', '2025-02-28 11:39:12'),
(62, 225, '225-62-1740762555.jpeg', NULL, '2025-02-28 11:39:15', '2025-02-28 11:39:15'),
(63, 225, '225-63-1740762557.jpeg', NULL, '2025-02-28 11:39:17', '2025-02-28 11:39:17');

-- --------------------------------------------------------

--
-- Table structure for table `product_ratings`
--

CREATE TABLE `product_ratings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `rating` double(3,2) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shipping_charges`
--

CREATE TABLE `shipping_charges` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `country_id` varchar(255) NOT NULL,
  `amount` double(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shipping_charges`
--

INSERT INTO `shipping_charges` (`id`, `country_id`, `amount`, `created_at`, `updated_at`) VALUES
(2, 'rest_of_world', 500.00, '2023-08-07 23:45:57', '2025-03-03 01:48:59'),
(5, '100', 50.00, '2023-08-08 00:00:11', '2025-03-03 01:48:50');

-- --------------------------------------------------------

--
-- Table structure for table `sub_categories`
--

CREATE TABLE `sub_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `status` int(11) NOT NULL,
  `showHome` enum('Yes','No') NOT NULL DEFAULT 'No',
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sub_categories`
--

INSERT INTO `sub_categories` (`id`, `name`, `slug`, `status`, `showHome`, `category_id`, `created_at`, `updated_at`) VALUES
(18, 'T-Shirt', 't-shirt', 1, 'No', 23, '2023-06-14 02:45:22', '2023-06-14 02:45:22'),
(19, 'Suit', 'suit', 1, 'No', 24, '2023-06-14 02:45:36', '2025-02-28 10:35:47'),
(25, 'Sarara', 'sarara', 1, 'Yes', 24, '2025-02-28 10:38:33', '2025-02-28 10:38:33'),
(26, 'kaftan suit', 'kaftan-suit', 1, 'Yes', 24, '2025-02-28 10:51:02', '2025-02-28 10:51:02'),
(27, 'Shimmer suit', 'shimmer-suit', 1, 'Yes', 24, '2025-02-28 10:56:57', '2025-02-28 10:56:57'),
(28, 'Fusion', 'fusion', 1, 'No', 24, '2025-02-28 10:58:21', '2025-02-28 11:01:49'),
(29, 'Indo western dress', 'indo-western-dress', 1, 'No', 24, '2025-02-28 11:01:32', '2025-02-28 11:01:41'),
(30, 'Linen fabric suit', 'linen-fabric-suit', 1, 'Yes', 24, '2025-02-28 11:36:27', '2025-02-28 11:36:27');

-- --------------------------------------------------------

--
-- Table structure for table `temp_images`
--

CREATE TABLE `temp_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `temp_images`
--

INSERT INTO `temp_images` (`id`, `name`, `created_at`, `updated_at`) VALUES
(101, '1700505370.jpg', '2023-11-20 13:06:10', '2023-11-20 13:06:10'),
(102, '1700505376.jpg', '2023-11-20 13:06:16', '2023-11-20 13:06:16'),
(103, '1740437014.jpeg', '2025-02-24 17:13:34', '2025-02-24 17:13:34'),
(104, '1740439599.png', '2025-02-24 17:56:39', '2025-02-24 17:56:39'),
(105, '1740439809.png', '2025-02-24 18:00:09', '2025-02-24 18:00:09'),
(106, '1740476862.png', '2025-02-25 04:17:43', '2025-02-25 04:17:43'),
(107, '1740476943.png', '2025-02-25 04:19:03', '2025-02-25 04:19:03'),
(108, '1740743672.png', '2025-02-28 06:24:32', '2025-02-28 06:24:32'),
(109, '1740758112.jpeg', '2025-02-28 10:25:12', '2025-02-28 10:25:12'),
(110, '1740758575.png', '2025-02-28 10:32:55', '2025-02-28 10:32:55'),
(111, '1740759344.jpeg', '2025-02-28 10:45:44', '2025-02-28 10:45:44'),
(112, '1740759355.jpeg', '2025-02-28 10:45:55', '2025-02-28 10:45:55'),
(113, '1740759364.jpeg', '2025-02-28 10:46:04', '2025-02-28 10:46:04'),
(114, '1740759858.jpeg', '2025-02-28 10:54:18', '2025-02-28 10:54:18'),
(115, '1740759866.jpeg', '2025-02-28 10:54:26', '2025-02-28 10:54:26'),
(116, '1740759874.jpeg', '2025-02-28 10:54:34', '2025-02-28 10:54:34'),
(117, '1740760183.jpeg', '2025-02-28 10:59:43', '2025-02-28 10:59:43'),
(118, '1740760189.jpeg', '2025-02-28 10:59:49', '2025-02-28 10:59:49'),
(119, '1740760510.jpeg', '2025-02-28 11:05:10', '2025-02-28 11:05:10'),
(120, '1740760517.jpeg', '2025-02-28 11:05:17', '2025-02-28 11:05:17'),
(121, '1740760524.jpeg', '2025-02-28 11:05:24', '2025-02-28 11:05:24'),
(122, '1740760735.jpeg', '2025-02-28 11:08:55', '2025-02-28 11:08:55'),
(123, '1740760746.jpeg', '2025-02-28 11:09:06', '2025-02-28 11:09:06'),
(124, '1740760754.jpeg', '2025-02-28 11:09:14', '2025-02-28 11:09:14'),
(125, '1740762491.jpeg', '2025-02-28 11:38:11', '2025-02-28 11:38:11'),
(126, '1740762501.jpeg', '2025-02-28 11:38:21', '2025-02-28 11:38:21'),
(127, '1740762510.jpeg', '2025-02-28 11:38:30', '2025-02-28 11:38:30');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `role` int(11) NOT NULL DEFAULT 1,
  `status` int(11) NOT NULL DEFAULT 1,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `role`, `status`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'info@makesmysite.com', NULL, 2, 1, NULL, '$2y$10$OL4t6a8FnJWCYYjUTnK6hub12ehaCZmL2FUvvCSgTDIKdbeltrQpC', NULL, '2023-03-18 13:24:00', '2023-09-23 15:07:07'),
(9, 'ravi kant', 'ravikant892123@gmail.com', '08789891918', 1, 1, NULL, '$2y$10$Mi6106ekpbjqn.YMYqgd6uSMJhovGWOsr.sQtjY8m36.rg3byep02', NULL, '2025-02-28 11:17:37', '2025-02-28 11:17:37');

-- --------------------------------------------------------

--
-- Table structure for table `wishlists`
--

CREATE TABLE `wishlists` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_addresses`
--
ALTER TABLE `customer_addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_addresses_user_id_foreign` (`user_id`),
  ADD KEY `customer_addresses_country_id_foreign` (`country_id`);

--
-- Indexes for table `discount_coupons`
--
ALTER TABLE `discount_coupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_user_id_foreign` (`user_id`),
  ADD KEY `orders_country_id_foreign` (`country_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_items_order_id_foreign` (`order_id`),
  ADD KEY `order_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_category_id_foreign` (`category_id`),
  ADD KEY `products_sub_category_id_foreign` (`sub_category_id`),
  ADD KEY `products_brand_id_foreign` (`brand_id`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_images_product_id_foreign` (`product_id`);

--
-- Indexes for table `product_ratings`
--
ALTER TABLE `product_ratings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_ratings_product_id_foreign` (`product_id`);

--
-- Indexes for table `shipping_charges`
--
ALTER TABLE `shipping_charges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sub_categories_category_id_foreign` (`category_id`);

--
-- Indexes for table `temp_images`
--
ALTER TABLE `temp_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `wishlists`
--
ALTER TABLE `wishlists`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wishlists_user_id_foreign` (`user_id`),
  ADD KEY `wishlists_product_id_foreign` (`product_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=243;

--
-- AUTO_INCREMENT for table `customer_addresses`
--
ALTER TABLE `customer_addresses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `discount_coupons`
--
ALTER TABLE `discount_coupons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=226;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `product_ratings`
--
ALTER TABLE `product_ratings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `shipping_charges`
--
ALTER TABLE `shipping_charges`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `sub_categories`
--
ALTER TABLE `sub_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `temp_images`
--
ALTER TABLE `temp_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=128;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `wishlists`
--
ALTER TABLE `wishlists`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customer_addresses`
--
ALTER TABLE `customer_addresses`
  ADD CONSTRAINT `customer_addresses_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `customer_addresses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_images`
--
ALTER TABLE `product_images`
  ADD CONSTRAINT `product_images_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_ratings`
--
ALTER TABLE `product_ratings`
  ADD CONSTRAINT `product_ratings_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD CONSTRAINT `sub_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `wishlists`
--
ALTER TABLE `wishlists`
  ADD CONSTRAINT `wishlists_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `wishlists_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
