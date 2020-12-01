Rails.application.routes.draw do
  resource :sudo, only: [] do
    collection do
      post :toggle
    end
  end
end
