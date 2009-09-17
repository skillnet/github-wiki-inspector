# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_github-wiki-inspector_session',
  :secret      => 'a27597b7384818c462a6a017f321e8caffb3eb0e24e45b0452cdb9d47470cde6e8f96372011214480e04afc03fdf8ac4b224f659839c0d40cae8edb6f87d6328'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
