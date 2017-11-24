describe package('openjdk-8-jdk') do
it { should be_installed }
end
describe processes('java') do
it { should exist }
end

describe service('artifactory') do
 it { should be_installed }
 it { should be_enabled }
it { should be_running }

end

describe processes('tomcat') do
it { should exist }
end

describe file('/root/jfrog-artifactory-oss-4.7.7.zip') do
 it {  should  exist }
its('mode') { should cmp '0644' }
end

describe bash('netstat -anp | grep 8081') do
its('stdout') { should match /java/ }
end

describe bash('ps -efl | grep root') do
its('stdout') { should match /artifactory/ }
end

describe directory('/root/artifactory-oss-4.7.7') do
 it {  should  exist }
end

describe port(8081) do
  it { should be_listening }
  its('processes') {should include 'java'}
end

describe file('/root/artifactory-oss-4.7.7/run/artifactory.pid') do
 it {  should  exist }
end

describe file('/root/artifactory-oss-4.7.7/tomcat/webapps/artifactory.war') do
 it {  should  exist }
its('owner') { should eq 'root' }
end

describe file('/etc/opt/jfrog/artifactory/default') do
 it {  should  exist }
its('mode') { should cmp '0644' }
end

describe bash('find /*/jfrog-artifactory-oss-4.7.7.zip -user root') do
its('stdout') { should match /artifactory/ }
end
