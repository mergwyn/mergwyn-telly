require 'facter'

# Default for non-Linux nodes
#
Facter.add(:telly_version) do
  setcode do
    nil
  end
end

# Linux
#
Facter.add(:telly_version) do
  confine kernel: :linux
  setcode do
    # telly_version = Facter::Util::Resolution.exec("wget -q https://github.com/telly/telly/releases/latest -O - | grep -E \/tag\/ | head -1 | sed 's:^.*/v\([0-9\.]*\)\".*:\1:'")
    telly_version = Facter::Util::Resolution.exec("wget -q https://github.com/tellytv/telly/releases/ -O - | grep -Po 'tag\/.*\">\K(\S+)' | head -1 | awk -F '[<>v\"]' '{print $1}'")
    if telly_version == ''
      nil
    else
      telly_version
    end
  end
end
