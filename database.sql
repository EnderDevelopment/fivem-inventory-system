CREATE TABLE IF NOT EXISTS player_inventory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    identifier VARCHAR(60) NOT NULL,
    items LONGTEXT NOT NULL,
    UNIQUE KEY unique_identifier (identifier)
);