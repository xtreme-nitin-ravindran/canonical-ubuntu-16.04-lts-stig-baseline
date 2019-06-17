exempt_home_users = attribute('exempt_home_users')
non_interactive_shells = attribute('non_interactive_shells')

control "V-75555" do
  title "All files and directories must have a valid owner."
  desc  "Unowned files and directories may be unintentionally inherited if a
user is assigned the same User Identifier \"UID\" as the UID of the un-owned
files."
  impact 0.5
  tag "gtitle": "SRG-OS-000480-GPOS-00227"
  tag "gid": "V-75555"
  tag "rid": "SV-90235r1_rule"
  tag "stig_id": "UBTU-16-010700"
  tag "fix_id": "F-82183r1_fix"
  tag "cci": ["CCI-002165"]
  tag "nist": ["AC-3 (4)", "Rev_4"]
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
  desc "check", "Verify all files and directories on the Ubuntu operating system
have a valid owner.

Check the owner of all files and directories with the following command:

# sudo find / -nouser

If any files on the system do not have an assigned owner, this is a finding."
  desc "fix", "Either remove all files and directories from the system that do
not have a valid user, or assign a valid user to all unowned files and
directories on the Ubuntu operating system with the \"chown\" command:

# sudo chown <user> <file>"

  ignore_shells = non_interactive_shells.join('|')

  findings = Set[]
  users.where{ !shell.match(ignore_shells) }.entries.each do |user_info|
    next if exempt_home_users.include?("#{user_info.username}")
    findings = findings + command("find / -nouser").stdout.split("\n")
  end

  describe "Files and Directories on the Ubuntu operating system have a valid owner" do
    subject { findings.to_a }
    it { should be_empty }
  end
end

