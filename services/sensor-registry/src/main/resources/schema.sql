CREATE TABLE IF NOT EXISTS sensors (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    model VARCHAR(50),
    location VARCHAR(100),
    created_at timestamp not null,
    updated_at timestamp not null,
    status VARCHAR(50)
);