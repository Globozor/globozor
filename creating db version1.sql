create table role(
role_id bigint(20) not null auto_increment,
role_description varchar(20),
constraint pk_role_id primary key(role_id)
);


create table payment_method(  
payment_method_id bigint(20) not null auto_increment,
payment_name varchar(150) not null unique,
description varchar(400) ,
constraint pk_payment_method primary key(payment_method_id)
);


create table language(  
language_id bigint(20) not null auto_increment,
language_name varchar(150) not null unique,
language_country varchar(400) ,
constraint pk_language primary key(language_id)
);


create table currency(  
currency_id bigint(20) not null auto_increment,
currency_name varchar(150) not null unique,
currency_country varchar(400) ,
constraint pk_currency primary key(currency_id)
);


create table membership_type(
membership_type_id bigint(20) not null auto_increment,
membership_type_name varchar(30) not null unique,
membership_type_description varchar(100),
constraint pk_membership_type primary key(membership_type_id)
);


create table country_lookup(
country_lookup_id bigint(20) not null auto_increment,
country_name varchar(400) not null unique,
ico_field varchar(4) unique,
extension varchar(20) unique,
constraint pk_country_lookup_id primary key(country_lookup_id)
);


create table state_lookup(
state_lookup_id bigint(20) not null auto_increment,
state_name varchar(400),
country_lookup_id bigint(20),
constraint pk_state_lookup_id primary key(state_lookup_id),
constraint fk_statelookup_countrylookup_id foreign key(country_lookup_id) references country_lookup(country_lookup_id)
);


create table master_table(
master_table_id bigint(20) not null auto_increment,
user_name varchar(500) not null unique,
email_id varchar(400) not null unique,
mobile_number varchar(300)not null unique,
password varchar(400) not null,
first_name varchar(150) not null ,
middle_name varchar(150) ,
last_name varchar(150) not null,
company_name varchar(150) unique,
website_url varchar(150) unique,
pan_number varchar(100)  unique,
iec_code_number varchar(100)  unique,
gst_number varchar(20)  unique,
is_verified tinyint default 0,
role_id bigint(20),

constraint pk_master_table primary key(master_table_id),
constraint fk_mastertable_role_id foreign key(role_id) references  role(role_id)
);


create table attachment_type_of_image(
attachment_type_of_image_id bigint(20) not null auto_increment,
attachment_description varchar(400) not null,
constraint pk_attactment_type_of_image primary key(attachment_type_of_image_id)
);


create table image(
image_id bigint(20) not null,
image_filepath mediumtext,
master_table_id bigint(20),
attachment_type_of_image_id bigint(20),

constraint pk_image_id primary key(image_id),
constraint fk_image_master_table_id foreign key(master_table_id) references master_table(master_table_id),
constraint fk_image_attachment_type_id foreign key(attachment_type_of_image_id) references attachment_type_of_image(attachment_type_of_image_id)
);


create table seller_description( 
seller_description_id bigint(20) not null auto_increment,
master_table_id bigint(20),
description_about_company mediumtext,
establishment smallint,
maximum_capacity bigint(20),
turnover decimal(20,6),
port varchar(400) not null,
number_of_employees bigint (20) not null, 
membership_type_id bigint(20),
membership_start_date datetime,
constraint pk_sellerdescription primary key (seller_description_id),
constraint fk_sellerdesc_membertype foreign key (membership_type_id) references  membership_type(membership_type_id),
constraint fk_sellerdesc_mastertable foreign key (master_table_id) references  master_table(master_table_id)
);


create table address_details(
address_details_id bigint(20) not null auto_increment,
master_table_id bigint(20),
address_line1 varchar(400) not null,
address_line2 varchar(400),
pincode bigint not null,
city varchar(400) not null,
country_lookup_id bigint(20),
state_lookup_id bigint(20),
address_type varchar(400) not null, -- mention home,office,factory from drop down in front end

constraint pk_address_details_id primary key(address_details_id),
constraint fk_addressdetail_mastertable_id foreign key(master_table_id) references  master_table(master_table_id),
constraint fk_addressdetails_countrylookup_id foreign key(country_lookup_id) references country_lookup(country_lookup_id),
constraint fk_addressdetails_statelookup_id foreign key(state_lookup_id) references state_lookup(state_lookup_id)
);


create table seller_paymentmethod(  -- Link Table
master_table_id bigint(20),
payment_method_id bigint(20),
constraint pk_seller_paymentmethod primary key(master_table_id,payment_method_id),
constraint fk_seller_paymentmethod foreign key(master_table_id) references master_table(master_table_id),
constraint fk_seller_payment_method foreign key(payment_method_id) references payment_method(payment_method_id)
);


create table mastertable_language(  -- Link Table
master_table_id bigint(20),
language_id bigint(20),
constraint pk_mastertable_language primary key(master_table_id,language_id),
constraint fk_mastertable_master foreign key(master_table_id) references master_table(master_table_id),
constraint fk_mastertable_language foreign key(language_id) references language(language_id));


create table seller_currency(  -- Link Table
master_table_id bigint(20),
currency_id bigint(20),
constraint pk_seller_currency primary key(master_table_id,currency_id),
constraint fk_sellercurrency_seller foreign key(master_table_id) references master_table(master_table_id),
constraint fk_sellercurrency_currency foreign key(currency_id) references currency(currency_id));


create table category(
category_id bigint(20) not null auto_increment,
category_name varchar(100) not null unique,
constraint pk_category primary key(category_id)
);


create table subcategory(
subcategory_id bigint(20) not null auto_increment,
subcategory_name varchar(30) not null unique,
constraint pk_subcategory primary key(subcategory_id)
);


create table product(
product_id bigint(20) not null auto_increment,
product_name varchar(30) not null unique,
product_description varchar(400),
constraint pk_product primary key(product_id)
);


create table subproduct(
subproduct_id bigint(20) not null auto_increment,
subproduct_name varchar(30) not null unique, 
subproduct_description mediumtext,
constraint pk_subproduct primary key(subproduct_id) 
);


create table subproduct_image(
subproduct_image_id bigint(20) not null auto_increment,
subproduct_id bigint(20),
filepath mediumtext not null ,
constraint pk_subproduct_image primary key(subproduct_image_id),
constraint fk_subprdt_image_subproductid foreign key (subproduct_id) references subproduct(subproduct_id)
);


create table category_subcategory( -- Link Table
category_id bigint(20),
subcategory_id bigint(20),
constraint pk_category_subcategory primary key(category_id,subcategory_id),
constraint fk_category_subcategory foreign key(category_id) references category(category_id),
constraint fk_category_sub_category foreign key(subcategory_id) references subcategory(subcategory_id)
);


create table subcategory_product( -- Link Table
subcategory_id bigint(20),
product_id bigint(20),
constraint pk_subcategory_product primary key(subcategory_id,product_id));


create table product_subproduct(  -- Link Table
product_id bigint(20),
subproduct_id bigint(20),
constraint pk_product_subproduct primary key(product_id,subproduct_id),
constraint fk_product_subproduct foreign key(product_id) references product(product_id),
constraint fk_product_sub_product foreign key(subproduct_id) references subproduct(subproduct_id)
);


create table seller_product(  
seller_product_id bigint(20) not null auto_increment,
subproduct_id bigint(20),
master_table_id bigint(20),
seller_product_name varchar(20) not null, 
seller_product_description varchar(100) ,
minimum_quantity bigint,
unit_price bigint(20) not null,
product_maturity varchar(300),
product_certification varchar(400),
product_weight varchar(400),
product_size varchar(400),
product_place_of_origin varchar(400),
product_shape varchar(400),
product_cultivation_type varchar(400),
is_verified tinyint default 0,

constraint pk_sellerproduct primary key(seller_product_id),
constraint fk_sellerproduct_productid foreign key (subproduct_id) references subproduct(subproduct_id),
constraint fk_sellerproduct_mastertableid foreign key (master_table_id) references master_table(master_table_id)
);


create table seller_product_image(
seller_product_image_id bigint(20) not null auto_increment,
seller_product_id bigint(20),
filepath mediumtext not null,
constraint pk_seller_product_image primary key(seller_product_image_id),
constraint fk_seller_product_image_prdtid foreign key (seller_product_id) references seller_product(seller_product_id)
);


create table transaction(
transaction_id bigint(20) not null auto_increment,
seller_id bigint(20),
seller_product_id bigint(20),
buyer_id bigint(20),
payment_method_id bigint(20),
unit_price decimal(20,6) not null, 
quantity decimal(20,6) not null,  
trade_amount decimal(20,6) not null,  
commission decimal(20,6) not null,  
vessel_name varchar(50) not null,
expected_shipping_date datetime ,
expected_arrival_date datetime ,
request_trade_date datetime ,
approved_trade_date datetime,
is_approved_trade_date tinyint not null,
close_trade_date datetime,
constraint pk_transaction primary key(transaction_id),
constraint fk_transaction_sellerid foreign key (seller_id) references master_table(master_table_id),
constraint fk_transaction_sellerproductid foreign key (seller_product_id) references seller_product(seller_product_id),
constraint fk_transaction_buyerid foreign key (buyer_id) references master_table(master_table_id),
constraint fk_transaction_paymentmethodid foreign key (payment_method_id) references payment_method(payment_method_id)
);


create table transaction_file(
transaction_file_id bigint(20) not null auto_increment,
transaction_id bigint(20),
buyer_filepath varchar(400)  unique, -- nullable
seller_filepath varchar(400)  unique, -- nullable
constraint pk_transaction_file primary key(transaction_file_id),
constraint fk_transactionfile_trid foreign key(transaction_id) references transaction(transaction_id)
);


create table payment_certificate(
payment_certificate_id bigint(20) not null auto_increment,
transaction_id bigint(20),
buyer_filepath varchar(400) unique,   
constraint pk_payment_certificate primary key(payment_certificate_id),
constraint fk_payment_certificate_trid foreign key(transaction_id) references transaction(transaction_id)
);


create table shipment_certificate(
shipment_certificate_id bigint(20) not null auto_increment,
transaction_id bigint(20),
buyer_filepath varchar(400) unique,  
seller_filepath varchar(400) unique, 
constraint pk_shipment_certificate primary key(shipment_certificate_id),
constraint fk_shipmentcertificate_trid foreign key(transaction_id) references transaction(transaction_id)
);


create table dispute(
dispute_id bigint(20) not null auto_increment,
transaction_id bigint(20),
dispute_name varchar(50) not null unique, -- Drop Down in Front End which will be fetched and stored here
description varchar(400) not null, 
constraint pk_dispute primary key(dispute_id),
constraint fk_dispute_transtnid foreign key(transaction_id) references transaction(transaction_id)
);


create table buyer_rating(  -- Buyer Rating from Seller will be stored in this table 
buyer_rating_id bigint(20) not null auto_increment,
transaction_id bigint(20),
rate decimal(5,2) not null,
description varchar(400) not null, 
constraint pk_buyer_rating primary key (buyer_rating_id),
constraint fk_buyer_rating_trid foreign key(transaction_id) references transaction(transaction_id)
);


create table seller_rating( -- Seller Rating from Buyer will be stored in this table
seller_rating_id bigint(20) not null auto_increment,
transaction_id bigint(20),
rate decimal(5,2) not null,
description varchar(400) not null,  
constraint pk_seller_rating primary key (seller_rating_id),
constraint fk_seller_rating_trid foreign key(transaction_id) references transaction(transaction_id)
);


create table subproduct_rating( -- Buyer Rating a Product will be stored in this table
subproduct_rating_id bigint(20) not null auto_increment,
transaction_id bigint(20) ,
rate decimal(5,2) not null,
description varchar(400) not null,  
constraint pk_subproduct_rating primary key (subproduct_rating_id),
constraint fk_subproduct_rating_trid foreign key(transaction_id) references transaction(transaction_id)
);


create table enquiry(  
enquiry_id bigint(20) not null auto_increment,
buyer_id bigint(20),
subproduct_id bigint(20) not null,
quantity bigint(20) not null,
unit varchar(300) not null, 
enquiry_description varchar(400) ,
filepath_attachments varchar(400),
constraint pk_enquiry primary key(enquiry_id),
constraint fk_enquiry_buyerid foreign key(buyer_id) references master_table(master_table_id),
constraint fk_enquiry_subproduct_id foreign key(subproduct_id) references subproduct(subproduct_id)
);


create table seller_enquiry_response(  
seller_enquiry_response_id bigint(20) not null auto_increment,
enquiry_id bigint(20),
buyer_id bigint(20),
seller_id bigint(20), -- Which Seller has responded what
subproduct_id bigint(20) not null,
quantity bigint(20) not null,
unit varchar(300) not null, 
enquiry_description varchar(400) ,
filepath_attachments varchar(400),
constraint pk_seller_response_enquiry primary key(seller_enquiry_response_id),
constraint fk_seller_response_enquiry_buyerid foreign key(buyer_id) references master_table(master_table_id),
constraint fk_seller_response_enquiry_sellerid foreign key(seller_id) references master_table(master_table_id),
constraint fk_seller_response_enquiry_subproduct_id foreign key(subproduct_id) references subproduct(subproduct_id),
constraint fk_seller_enquiry_id foreign key(enquiry_id) references enquiry(enquiry_id)
);


create table company_profile(
company_profile_id bigint(20) not null auto_increment,
master_table_id bigint(20),
business_type varchar(400),
export_percentage varchar(400),
source_across_multiple_industries varchar(10),
average_lead_time varchar(400),
overseas_office varchar(10), -- Answer in yes or No
certificate_filepath varchar(400),
constraint pk_company_profile primary key(company_profile_id),
constraint fk_companyprofile_masterid foreign key(master_table_id) references master_table(master_table_id)
);


create table trade_show(
trade_show_id bigint(20) not null auto_increment,
company_profile_id bigint(20),
trade_show_name varchar(400),
trade_show_date datetime,
trade_show_host varchar(400),
trade_show_description varchar(400),
trade_show_filepath varchar(400),
constraint pk_trade_show primary key(trade_show_id),
constraint fk_tradeshow_companyprofile foreign key(company_profile_id) references company_profile(company_profile_id)
);


create table customer_detail(		
customer_id bigint(20) not null auto_increment,
company_profile_id bigint(20),
customer_name varchar(400) not null,
customer_country varchar(400),
product_supply varchar(400), -- Can be Multiple Separate By Comma
annual_turnover varchar(400),
transaction_document varchar(40) not null,
constraint pk_customer_detail primary key(customer_id),
constraint fk_customer_detail_companyprofile foreign key(company_profile_id) references company_profile(company_profile_id)
);

