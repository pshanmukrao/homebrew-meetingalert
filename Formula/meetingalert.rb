class Meetingalert < Formula
  desc "Menu bar app that shows upcoming meetings and auto-opens Zoom links"
  homepage "https://github.com/AkhilaShanmukha/MeetingAlert"
  url "https://github.com/AkhilaShanmukha/MeetingAlert/releases/download/v1.0/MeetingAlert-1.0.zip"
  sha256 "1617ae374005cb3808256fa21d75f5b02d816151c1df6962468cd0a5a14f86dc"
  version "1.0"
  license "MIT"

  depends_on macos: :ventura # macOS 13.0+

  def install
    # The ZIP contains MeetingAlert.app at the root
    # Homebrew extracts ZIPs - check if buildpath itself is the app or contains it
    app = if (buildpath/"MeetingAlert.app").directory?
            buildpath/"MeetingAlert.app"
          elsif buildpath.basename.to_s == "MeetingAlert.app" && buildpath.directory?
            buildpath
          else
            # Try to find it
            found = buildpath.find { |p| p.basename.to_s == "MeetingAlert.app" && p.directory? }
            found || raise("MeetingAlert.app not found in #{buildpath}")
          end
    
    # Copy the app to the prefix (Cellar location)
    prefix.install app => "MeetingAlert.app"
    
    # Create Applications symlink for easy access
    app_dir = Pathname.new("#{HOMEBREW_PREFIX}/Applications")
    app_dir.mkpath
    ln_sf "#{prefix}/MeetingAlert.app", "#{app_dir}/MeetingAlert.app"
  end

  def caveats
    <<~EOS
      MeetingAlert has been installed!
      
      A symlink has been created in Applications for easy access.
      You can also find it at: #{opt_prefix}/MeetingAlert.app
      
      To start using it:
      1. Open MeetingAlert from Applications, or run: open #{opt_prefix}/MeetingAlert.app
      2. Grant calendar permissions when prompted
      3. Look for the app icon in your menu bar
      
      The app will appear in your menu bar showing upcoming meetings.
      Click it to see a list of events and auto-open Zoom links.
    EOS
  end

  test do
    # Test that the app exists
    assert_predicate prefix/"MeetingAlert.app", :exist?
  end
end

