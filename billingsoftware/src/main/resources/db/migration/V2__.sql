CREATE TABLE revchanges
(
    rev        BIGINT       NOT NULL,
    entityname VARCHAR(255) NULL
);

CREATE TABLE revinfo
(
    rev      BIGINT NOT NULL,
    revtstmp BIGINT NULL,
    CONSTRAINT pk_revinfo PRIMARY KEY (rev)
);

ALTER TABLE revchanges
    ADD CONSTRAINT fk_revchanges_on_default_tracking_modified_entities_changelog FOREIGN KEY (rev) REFERENCES revinfo (rev);

ALTER TABLE tbl_orders
    DROP COLUMN payment_id;

ALTER TABLE tbl_orders
    DROP COLUMN signature;

ALTER TABLE tbl_orders
    DROP COLUMN payment_method;

ALTER TABLE tbl_variants
    MODIFY base_price DECIMAL;

ALTER TABLE tbl_promotions
    MODIFY bogo_discount_percent DECIMAL;

ALTER TABLE tbl_items
    MODIFY category_id BIGINT NOT NULL;

ALTER TABLE tbl_category
    MODIFY created_at datetime(6) NULL;

ALTER TABLE tbl_customers
    MODIFY created_at datetime(6) NULL;

ALTER TABLE tbl_inventory_transactions
    MODIFY created_at datetime(6) NULL;

ALTER TABLE tbl_items
    MODIFY created_at datetime(6) NULL;

ALTER TABLE tbl_modifier_groups
    MODIFY created_at datetime(6) NULL;

ALTER TABLE tbl_modifiers
    MODIFY created_at datetime(6) NULL;

ALTER TABLE tbl_promotions
    MODIFY created_at datetime(6) NULL;

ALTER TABLE tbl_users
    MODIFY created_at datetime(6) NULL;

ALTER TABLE tbl_variants
    MODIFY created_at datetime(6) NULL;

ALTER TABLE tbl_promotions
    DROP COLUMN discount_type;

ALTER TABLE tbl_promotions
    DROP COLUMN type;

ALTER TABLE tbl_promotions
    ADD discount_type VARCHAR(255) NULL;

ALTER TABLE tbl_promotions
    MODIFY discount_value DECIMAL;

ALTER TABLE tbl_promotions
    MODIFY max_discount_amount DECIMAL;

ALTER TABLE tbl_promotions
    MODIFY min_order_amount DECIMAL;

ALTER TABLE tbl_orders
    ADD payment_method VARCHAR(255) NULL;

ALTER TABLE tbl_items
    MODIFY price DECIMAL;

ALTER TABLE tbl_modifiers
    MODIFY price_adjustment DECIMAL;

ALTER TABLE tbl_inventory_transactions
    DROP COLUMN transaction_type;

ALTER TABLE tbl_inventory_transactions
    ADD transaction_type VARCHAR(255) NOT NULL;

ALTER TABLE tbl_promotions
    ADD type VARCHAR(255) NOT NULL;

ALTER TABLE tbl_category
    MODIFY updated_at datetime(6) NULL;

ALTER TABLE tbl_customers
    MODIFY updated_at datetime(6) NULL;

ALTER TABLE tbl_items
    MODIFY updated_at datetime(6) NULL;

ALTER TABLE tbl_modifier_groups
    MODIFY updated_at datetime(6) NULL;

ALTER TABLE tbl_modifiers
    MODIFY updated_at datetime(6) NULL;

ALTER TABLE tbl_promotions
    MODIFY updated_at datetime(6) NULL;

ALTER TABLE tbl_users
    MODIFY updated_at datetime(6) NULL;

ALTER TABLE tbl_variants
    MODIFY updated_at datetime(6) NULL;