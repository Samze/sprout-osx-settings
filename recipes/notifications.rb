prefs = node['sprout']['notifications']

plist_dir = "#{node['sprout']['home']}/Library/Preferences/ByHost"
domains = Dir["#{plist_dir}/com.apple.notificationcenterui.*.plist"].map do |f|
  domain = File.basename(f).chomp('.plist')
  "ByHost/#{domain}"
end

domains.each do |domain|
  osx_defaults "sets dnd mode when mirroring" do
    domain domain
    key 'dndMirroring'
    boolean prefs['dndMirroring']
    only_if { prefs.keys.include?('dndMirroring') }
  end
end
