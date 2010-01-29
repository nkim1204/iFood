# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_iFood_session',
  :secret      => '8c9fffe5a8d38d796b76116794102463f77bc718b134c3f865be2cf0bc0f3afccf83975a1b949386fc27bbafc5586d550179af24692fd5248091c33389c91d27'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
