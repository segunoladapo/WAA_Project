"# WAA_Project" 
Only an existing user can be made an administrator.
To assign a user as an administrator, the user profile in table person has to be assign the following values:
is_admin=1
role=ADMIN
Below is a sample script
INSERT INTO `db_coffee`.`person` (`id`, `email`, `enable`, `first_name`, `is_admin`, `last_name`, `password`, `phone`, `role`, `address_id`) VALUES ('2', 'admin@email.com', b'0', 'Foo', b'1', 'Foo', 'password', '6543568909', 'ADMIN', '1');

