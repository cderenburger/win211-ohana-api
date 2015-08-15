class MailAddressImporter < EntityImporter
  def valid?
    @valid ||= mail_addresses.all?(&:valid?)
  end

  def errors
    ImporterErrors.messages_for(mail_addresses)
  end

  def import
    mail_addresses.each(&:save)
  end

  protected

  def mail_addresses
    @mail_addresses ||= csv_entries.map(&:to_hash).map do |p|
      MailAddressPresenter.new(p).to_mail_address
    end
  end

  def self.required_headers
    %w(id location_id attention address_1 address_2 city state_province postal_code
       country)
  end
end
