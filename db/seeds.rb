# Generated with RailsBricks
# Initial seed file to use with Devise User Model

# Temporary admin account
u = User.new(
    email: "admin@example.com",
    password: "1234",
    password_confirmation: "1234",
    admin: true
)
u.skip_confirmation!
u.save!

u = User.new(
    email: "leo@example.com",
    password: "1234",
    password_confirmation: "1234",
    admin: false
)
u.skip_confirmation!
u.save!

#
# project seed...
#
