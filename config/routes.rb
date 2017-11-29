Rails.application.routes.draw do
  scope "/:locale", locale: /#{I18n.available_locales.join("|")}/ do
    resources :islands

    devise_for :users, path: 'auth',
      path_name: {
        sign_in: 'login',
        sign_out: 'logout',
        edit: 'profile'
      }

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root 'home#index'
  end

  root to: redirect("/#{I18n.default_locale}", status: 302), as: :redirected_root

  get "/*path", to: redirect("/#{I18n.default_locale}/%{path}", status: 302), constraints: {path: /(?!(#{I18n.available_locales.join("|")})\/).*/}, format: false
end
