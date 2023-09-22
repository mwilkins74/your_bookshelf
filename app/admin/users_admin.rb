Trestle.resource(:users) do
  menu do
    item :users, icon: "fa fa-users"
  end

  table do
    column :username
    column :email
    column :created_at, align: :center
    column :admin, align: :center
    column "Books Read This Year", align: :center do |user|
      user.books.where("strftime('%Y', created_at) = ?", Date.today.year.to_s).count
    end

    actions
  end

  form do |user|
    text_field :username
    text_field :email

    row do
      col { check_box :admin }
    end

    row do
      col { datetime_field :updated_at }
      col { datetime_field :created_at }
    end

    row do
      col { static_field "Books Read This Year", user.books.where("strftime('%Y', created_at) = ?", Date.today.year.to_s).count }
    end
  end
end
