require 'rails_helper'

feature 'Update phones' do
  background do
    create_service
    login_super_admin
    visit '/admin/locations/vrs-services'
    click_link 'Literacy Program'
  end

  scenario 'when no phones exist' do
    expect(page).to have_link 'Add a new phone number'
  end

  scenario 'by adding a new phone', :js do
    add_phone(
      number: '123-456-7890',
      number_type: 'TTY',
      department: 'Director of Development',
      extension: '1234',
      vanity_number: '123-ABC-DEFG',
      phone_hours:  'M-F, 8am-5pm'
    )
    click_button 'Save changes'

    expect(find_field('service_phones_attributes_0_number').value).
      to eq '123-456-7890'

    expect(find_field('service_phones_attributes_0_number_type').value).
      to eq 'tty'

    expect(find_field('service_phones_attributes_0_department').value).
      to eq 'Director of Development'

    expect(find_field('service_phones_attributes_0_extension').value).
      to eq '1234'

    expect(find_field('service_phones_attributes_0_vanity_number').value).
      to eq '123-ABC-DEFG'

    expect(find_field('service_phones_attributes_0_phone_hours').value).
      to eq 'M-F, 8am-5pm'

    delete_phone
    within('.phones') do
      expect(page).
        to have_no_xpath('.//input[contains(@name, "[vanity_number]")]')
    end
  end
end
