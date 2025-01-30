INSERT INTO wp_options (option_name, option_value) VALUES ('siteurl', 'http://localhost')
ON DUPLICATE KEY UPDATE option_value = 'http://localhost';

INSERT INTO wp_options (option_name, option_value) VALUES ('blogname', 'My WordPress Site')
ON DUPLICATE KEY UPDATE option_value = 'My WordPress Site';
