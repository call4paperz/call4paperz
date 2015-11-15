class Authentication < ActiveRecord::Base
  class Provider
    attr_accessor :name, :aka

    def initialize(name, aka = nil)
      @name, @aka = name, aka
      @aka = @name unless @aka
    end

    def ==(profile)
      name == profile.name &&
        aka == profile.aka
    end
    alias_method :eql?, :==

    def show_name
      aka.to_s.capitalize
    end
  end

  belongs_to :user

  attr_accessor :auth_info

  def self.providers(raw = false)
    @providers ||= [
      Provider.new(:github),
      Provider.new(:twitter),
      Provider.new(:facebook),
      Provider.new(:google_oauth2, :google),
    ]
  end

  def self.providers_not_in(authentications)
    current_providers = authentications.map { |auth| provider_by_name(auth.provider) }
    providers(true) - current_providers
  end

  def self.provider_by_name(name_or_aka)
    name_or_aka = name_or_aka.to_sym
    providers.find { |provider|
      provider.name == name_or_aka || provider.aka == name_or_aka
    }
  end

  private_class_method :provider_by_name

  [ :name, :image, :email ].each do |_method|
    define_method _method do
      auth_info[_method.to_s]
    end
  end
end
