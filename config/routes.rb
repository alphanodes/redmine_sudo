resource :sudo, only: [] do
  collection do
    post :toggle
  end
end
