# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Todo.destroy_all

# 在 iterm 命令列輸入 `rails db:seed` 生成原始資料
todo_list = [
  {
    title:    'Learn ROR',
    due_date: '2017-11-13'
  },
  {
    title:    'Date with someone',
    due_date: '2017-11-15'
  },
  {
    title:    'ROR-S10 Deadline ',
    due_date: '2017-11-20'
  },
  {
    title:    'Go to Japan',
    due_date: '2018-01-24'
  },
  {
    title:    'Chinese New Year',
    due_date: '2018-02-16'
  },
]

todo_list.each do |todo|
  Todo.create(
    title:    todo[:title],
    due_date: todo[:due_date]
  )
end