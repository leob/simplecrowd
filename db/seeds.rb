# Generated with RailsBricks
# Initial seed file to use with Devise User Model

# Temporary admin account
# u = User.new(
#     email: "admin@example.com",
#     password: "1234",
#     password_confirmation: "1234",
#     admin: true
# )
# u.skip_confirmation!
# u.save!
#
# u = User.new(
#     email: "leo@example.com",
#     password: "1234",
#     password_confirmation: "1234",
#     admin: false
# )
# u.skip_confirmation!
# u.save!

#
# project seed...
#

#
# category seed
#
def add_cat(name_en, name_nl)
    c = Category.new(name_en: name_en, name_nl: name_nl)
    c.save!
end

add_cat "Animals", "Dieren"
add_cat "Business", "Bedrijf"
add_cat "Community", "Gemeenschap"
add_cat "Medical", "Medisch"
add_cat "Personal", "Persoonlijk"
add_cat "Sports", "Sport"
add_cat "Third World", "Derde wereld"
add_cat "Other", "Overig"