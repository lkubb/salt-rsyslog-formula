# frozen_string_literal: true

control 'rsyslog.package.install' do
  title 'The required package should be installed'

  package_name = 'rsyslog'

  describe package(package_name) do
    it { should be_installed }
  end
end
