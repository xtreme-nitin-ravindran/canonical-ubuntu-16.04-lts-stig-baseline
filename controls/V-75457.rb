# frozen_string_literal: true

control 'V-75457' do
  title "The Ubuntu operating system must require the change of at least 8
characters when passwords are changed."
  desc  "If the Ubuntu operating system allows the user to consecutively reuse
extensive portions of passwords, this increases the chances of password
compromise by increasing the window of opportunity for attempts at guessing and
brute-force attacks.

    The number of changed characters refers to the number of changes required
with respect to the total number of positions in the current password. In other
words, characters may be the same within the two passwords; however, the
positions of the like characters must be different.

    If the password length is an odd number then number of changed characters
must be rounded up. For example, a password length of 15 characters must
require the change of at least 8 characters.
  "
  impact 0.5
  tag "gtitle": 'SRG-OS-000072-GPOS-00040'
  tag "gid": 'V-75457'
  tag "rid": 'SV-90137r2_rule'
  tag "stig_id": 'UBTU-16-010140'
  tag "fix_id": 'F-82085r2_fix'
  tag "cci": ['CCI-000195']
  tag "nist": ['IA-5 (1) (b)', 'Rev_4']
  tag "false_negatives": nil
  tag "false_positives": nil
  tag "documentable": false
  tag "mitigations": nil
  tag "severity_override_guidance": false
  tag "potential_impacts": nil
  tag "third_party_tools": nil
  tag "mitigation_controls": nil
  tag "responsibility": nil
  tag "ia_controls": nil
  desc 'check', "Verify the Ubuntu operating system requires the change of at
least \"8\" characters when passwords are changed.

Determine if the field \"difok\" is set in the \"/etc/security/pwquality.conf\"
file with the following command:

# grep -i \"difok\" /etc/security/pwquality.conf
difok=8

If the \"difok\" parameter is less than \"8\", or is commented out, this is a
finding."
  desc 'fix', "Configure the Ubuntu operating system to require the change of at
least \"8\" characters when passwords are changed.

Add or update the following line in the \"/etc/security/pwquality.conf\" file
to include the \"difok=8\" parameter:

difok=8"

  min_num_characters_to_change = input('min_num_characters_to_change')
  config_file = '/etc/security/pwquality.conf'
  config_file_exists = file(config_file).exist?

  if config_file_exists
    describe parse_config_file(config_file) do
      its('difok') { should cmp min_num_characters_to_change }
    end
  else
    describe (config_file + ' exists') do
      subject { config_file_exists }
      it { should be true }
    end
  end
end
