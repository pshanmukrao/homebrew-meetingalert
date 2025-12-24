class Meetingalert < Formula
  desc "Menu bar app that shows upcoming meetings and auto-opens Zoom links"
  homepage "https://github.com/AkhilaShanmukha/MeetingAlert"
  url "https://github.com/AkhilaShanmukha/MeetingAlert/releases/download/v1.0/MeetingAlert-1.0.zip"
  sha256 "1617ae374005cb3808256fa21d75f5b02d816151c1df6962468cd0a5a14f86dc"
  version "1.0"
  license "MIT"

  depends_on macos: :ventura # macOS 13.0+

  def install
    # Homebrew extracts ZIPs - the ZIP contains MeetingAlert.app/ at root
    # After extraction, buildpath should contain MeetingAlert.app
    app_source = buildpath/"MeetingAlert.app"
    
    unless app_source.directory?
      # If not found, list what's actually there for debugging
      raise "MeetingAlert.app not found in #{buildpath}. Found: #{buildpath.children.map(&:basename).join(', ')}"
    end
    
    # Use cp_r to copy the app bundle
    prefix.mkpath
    cp_r app_source, prefix/"MeetingAlert.app"
  end

  def caveats
    <<~EOS
      MeetingAlert has been installed to #{opt_prefix}/MeetingAlert.app
      
      To start using it:
      1. Run: open #{opt_prefix}/MeetingAlert.app
      2. Grant calendar permissions when prompted
      3. Look for the app icon in your menu bar
      
      Optional: To add to Applications folder:
        ln -sf #{opt_prefix}/MeetingAlert.app /Applications/MeetingAlert.app
      
      The app will appear in your menu bar showing upcoming meetings.
      Click it to see a list of events and auto-open Zoom links.
    EOS
  end

  test do
    # Test that the app exists
    assert_predicate prefix/"MeetingAlert.app", :exist?
  end
end

