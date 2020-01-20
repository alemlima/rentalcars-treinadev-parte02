require 'rails_helper'

feature 'Admin register rental addons' do
  scenario 'successfully' do
    admin = create(:user, :admin)

    login_as admin
    visit root_path
    click_on 'Adicionais de locação'
    click_on 'Cadastrar'
    fill_in 'Nome', with: 'Bebê conforto'
    fill_in 'Descrição', with: 'Uma cadeirinha para bebês'
    fill_in 'Diária padrão', with: 10.0
    attach_file 'Foto', Rails.root.join('spec', 'fixtures', 'baby_chair.jfif')
    click_on 'Criar Adicional'

    expect(page).to have_content('Adicional criado com sucesso')
    expect(page).to have_content('Bebê conforto')
    expect(page).to have_content('Uma cadeirinha para bebês')
    expect(page).to have_content('Diária padrão: R$ 10,0')
    expect(page).to have_css('img[src*="baby_chair.jfif"]')
  end

  scenario 'and must fill all fields' do
    admin = create(:user, :admin)

    login_as admin
    visit root_path
    click_on 'Adicionais de locação'
    click_on 'Cadastrar'
    click_on 'Criar Adicional'

    expect(page).to have_content('Não foi possível gravar Adicional: 3 erros')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Diária padrão não pode ficar em branco')
  end

  scenario 'and pluralize errors' do
    admin = create(:user, :admin)

    login_as admin
    visit root_path
    click_on 'Adicionais de locação'
    click_on 'Cadastrar'
    fill_in 'Descrição', with: 'Uma cadeirinha para bebês'
    click_on 'Criar Adicional'

    expect(page).to have_content('Não foi possível gravar Adicional: 2 erros')
  end

  scenario 'successfully and generates prices automatically' do
    admin = create(:user, :admin)
    create(:subsidiary)

    login_as admin
    visit root_path
    click_on 'Adicionais de locação'
    click_on 'Cadastrar'
    fill_in 'Nome', with: 'Bebê conforto'
    fill_in 'Descrição', with: 'Uma cadeirinha para bebês'
    fill_in 'Diária padrão', with: 23.0
    attach_file 'Foto', Rails.root.join('spec', 'fixtures', 'baby_chair.jfif')
    click_on 'Criar Adicional'
    click_on 'Preços de adicionais'

    expect(page).to have_content('Bebê conforto')
    expect(page).to have_content('R$ 23,0')
  end
end
