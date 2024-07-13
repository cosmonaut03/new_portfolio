module LoginMacros
    def login(user)
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: '12345678'
      click_on(id: 'modal-login-btn');
    end

    def sign_in
      click_on(id: "head-new-link")
      fill_in 'メールアドレス', with: 'example@example.com'
      fill_in 'パスワード', with: '12345678'
      click_on(id: "modal-new-btn")
    end
end