#!/bin/bash
echo "パスワードマネージャーへようこそ！"

password_manage_file="password_manage.txt"

save_password() {
    echo "$service_name:$user_name:$password" >> "$password_manage_file"
}

echo "次の選択肢から入力してください(Add Password/Get Password/Exit):"
read user_chosen

if [ "$user_chosen" = "Add Password" ]; then
    echo "サービス名を入力してください："
    read service_name
    echo "ユーザー名を入力してください："
    read user_name
    echo "パスワードを入力してください："
    read password
    save_password
    echo "パスワードの追加は成功しました。"

elif [ "$user_chosen" = "Get Password" ]; then
    echo "サービス名を入力してください:"
    read service_name

    entry=$(grep "^$service_name:" "$password_manage_file")

    if [ -n "$entry" ]; then
        IFS=':' read -r service_name user_name password <<< "$entry"

        echo "サービス名：$service_name"
        echo "ユーザー名：$user_name"
        echo "パスワード：$password"
    else
        echo "そのサービス名は登録されていません。"
    fi
elif [ "$user_chosen" = "Exit" ]; then
    echo "Thank you!"
else
    echo "入力が間違えています。Add Password/Get Password/Exitから入力してください。"
fi