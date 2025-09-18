# Темы
nature = Theme.find_or_create_by!(name: "Лес")
tech   = Theme.find_or_create_by!(name: "Саванна")

def add_image(theme, title, file_name)
  img = theme.images.find_or_create_by!(title: title)
  return if img.photo.attached?   # ✅ теперь правильно
  path = Rails.root.join("app/assets/images/seeds", file_name)
  img.photo.attach(
    io: File.open(path),
    filename: file_name,
    content_type: "image/jpeg"
  )
end

add_image(nature, "Волк",  "p1.jpg")
add_image(tech, "Тигр", "p2.jpg")
add_image(tech,   "Лев", "p3.jpg")
add_image(tech,   "Пантера", "p4.jpg")

puts "Seeds loaded."
