# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_crisco_session',
  :secret      => '73090e1097d8b9bd8aae3dac8b263b8772d17b71a5e1054a4337557f5eecb9a9d45082f5d21aeb32d5191957d01ab6d1d7a2f714ce14f47a62b857d233c8a096'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
