Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '433592010474964', '547da79dec038a932f4c846986398f63'
  provider :google_oauth2, '244615150400-05thnta81fhg631up71t8v7e167i8pta.apps.googleusercontent.com', 'XW9LFZYGtLjruVh9kOpmCaRY', scope: 'userinfo.profile,youtube,email', provider_ignores_state: true, prompt: :consent
  # provider :google_oauth2, '781334102649-uks4t2v7p1cj2eintve3su7pjj5u8jrp.apps.googleusercontent.com', '9wcfYGe05Cht8rsiytU58-nK', scope: 'userinfo.profile,youtube,email', provider_ignores_state: true, prompt: :consent
end


# provider :google_oauth2, '833205051824-d671rg92184srjelrtro077sf5elvl82.apps.googleusercontent.com', 'ytA90VQIETx3LtN_IjjOeNJD', scope: 'userinfo.profile,youtube,email', provider_ignores_state: true, prompt: :consent