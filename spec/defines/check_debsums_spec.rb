require 'spec_helper'

describe "check_debsums" do

  describe "with packages not being an array" do
    let(:title) { 'foobar' }
    let(:params) {{
      :packages => 'baz',
    }}

    it do
      expect {
        should contain_file('/etc/nagios/nrpe.d/check_debsums.cfg')
      }.to raise_error(Puppet::Error, /packages must be an array: 'baz'/)
    end
  end

  describe "with packages being an array" do
    let(:title) { 'foobar' }
    let(:params) {{
      :packages => ['bar', 'baz'],
    }}

    it "should create a check_debsums nrpe check" do
      should contain_file('/etc/nagios/nrpe.d/check_debsums_foobar.cfg')\
        .with_content("command[check_debsums_foobar]=sudo /usr/lib/nagios/plugins/check_debsums bar baz")\
        .with_notify("Service[nagios-nrpe-server]") \
        .with( 'require' => ['Class[Check_debsums::Package]','Package[nagios-nrpe-server]'])
    end
  end
end
