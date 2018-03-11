/******
* name: ghacks user.js
* date: 3 February 2018
* version 58: Pantslide
*   "I took my pants, took em down, I climbed a mountain and I turned around"
* authors: v52+ github | v51- www.ghacks.net
* url: https://github.com/ghacksuserjs/ghacks-user.js
* license: MIT: https://github.com/ghacksuserjs/ghacks-user.js/blob/master/LICENSE.txt

* releases: These are end-of-stable-life-cycle legacy archives.
            *Always* use the master branch user.js for a current up-to-date version.
       url: https://github.com/ghacksuserjs/ghacks-user.js/releases

* README:

  1. READ the full README
     * https://github.com/ghacksuserjs/ghacks-user.js/blob/master/README.md
  2. READ this
     * https://github.com/ghacksuserjs/ghacks-user.js/wiki/1.3-Implementation
  3. If you skipped steps 1 and 2 above (shame on you), then here is the absolute minimum
     * Auto-installing updates for Firefox and extensions are disabled (section 0302's)
     * Some user data is erased on close (section 2800), namely history (browsing, form, download)
     * Cookies are denied by default (2701), we use site exceptions. In Firefox 58 and lower, this breaks
       extensions that use IndexedDB, so you need to allow exceptions for those as well: see [1] below
       [1] https://github.com/ghacksuserjs/ghacks-user.js/wiki/4.1.1-Setting-Extension-Permission-Exceptions
     * EACH RELEASE check:
         - 4600s: reset prefs made redundant due to privacy.resistFingerprinting (RPF)
                  or enable them as an alternative to RFP or for ESR users
         - 9999s: reset deprecated prefs in about:config or enable relevant section(s) for ESR
     * Site breakage WILL happen
         - There are often trade-offs and conflicts between Security vs Privacy vs Anti-Fingerprinting
           and these need to be balanced against Functionality & Convenience & Breakage
     * You will need to make a few changes to suit your own needs
         - Search this file for the "[SETUP]" tag to find SOME common items you could check
           before using to avoid unexpected surprises
         - Search this file for the "[WARNING]" tag to troubleshoot or prevent SOME common issues
  4. BACKUP your profile folder before implementing (and/or test in a new/cloned profile)
  5. KEEP UP TO DATE: https://github.com/ghacksuserjs/ghacks-user.js/wiki#small_orange_diamond-maintenance

 ******/

/* START: internal custom pref to test for syntax errors (thanks earthling)
 * Yes, this next pref setting is redundant, but we like it!
 * [1] https://en.wikipedia.org/wiki/Dead_parrot
 * [2] https://en.wikipedia.org/wiki/Warrant_canary ***/
user_pref("_user.js.parrot", "START: Oh yes, the Norwegian Blue... what's wrong with it?");

/* 0000: disable about:config warning ***/
user_pref("general.warnOnAboutConfig", false);

/* 0001: start Firefox in PB (Private Browsing) mode
 * [SETTING-56+] Options>Privacy & Security>History>Custom Settings>Always use private browsing mode
 * [SETTING-ESR] Options>Privacy>History>Custom Settings>Always use private browsing mode
 * [NOTE] In this mode *all* windows are "private windows" and the PB mode icon is not displayed
 * [NOTE] The P in PB mode is misleading: it means no "persistent" local storage of history,
 * caches, searches or cookies (which you can achieve in normal mode). In fact, it limits or
 * removes the ability to control these, and you need to quit Firefox to clear them. PB is best
 * used as a one off window (File>New Private Window) to provide a temporary self-contained
 * new instance. Closing all Private Windows clears all traces. Repeat as required.
 * [WARNING] PB does not allow indexedDB which breaks many Extensions that use it
 * including uBlock Origin, uMatrix, Violentmonkey and Stylus
 * [1] https://wiki.mozilla.org/Private_Browsing ***/
   // user_pref("browser.privatebrowsing.autostart", true);

/*** 0100: STARTUP ***/
user_pref("_user.js.parrot", "0100 syntax error: the parrot's dead!");
/* 0101: disable "slow startup" options
 * warnings, disk history, welcomes, intros, EULA, default browser check ***/
user_pref("browser.slowStartup.notificationDisabled", true);
user_pref("browser.slowStartup.maxSamples", 0);
user_pref("browser.slowStartup.samples", 0);
user_pref("browser.rights.3.shown", true);
user_pref("browser.startup.homepage_override.mstone", "ignore");
user_pref("startup.homepage_welcome_url", "");
user_pref("startup.homepage_welcome_url.additional", "");
user_pref("startup.homepage_override_url", ""); // what's new page after updates
user_pref("browser.laterrun.enabled", false);
user_pref("browser.shell.checkDefaultBrowser", false);
/* 0102: set start page (0=blank, 1=home, 2=last visited page, 3=resume previous session)
 * [SETTING] Options>General>Startup>When Firefox starts ***/
   // user_pref("browser.startup.page", 0);
/* 0103: set your "home" page (see 0102) ***/
   // user_pref("browser.startup.homepage", "https://www.example.com/");

/*** 0200: GEOLOCATION ***/
user_pref("_user.js.parrot", "0200 syntax error: the parrot's definitely deceased!");
/* 0202: disable GeoIP-based search results
 * [NOTE] May not be hidden if Firefox has changed your settings due to your locale
 * [1] https://trac.torproject.org/projects/tor/ticket/16254
 * [2] https://support.mozilla.org/en-US/kb/how-stop-firefox-making-automatic-connections#w_geolocation-for-default-search-engine ***/
user_pref("browser.search.countryCode", "US"); // (hidden pref)
user_pref("browser.search.region", "US"); // (hidden pref)
user_pref("browser.search.geoip.url", "");
/* 0203: disable using OS locale, force APP locale ***/
user_pref("intl.locale.matchOS", false);
/* 0204: set APP locale ***/
user_pref("general.useragent.locale", "en-US");
/* 0205: set OS & APP locale (replaces 0203 + 0204) (FF59+)
 * If set to empty, the OS locales are used. If not set at all, default locale is used ***/
user_pref("intl.locale.requested", "en-US"); // (hidden pref)
/* 0206: disable geographically specific results/search engines e.g. "browser.search.*.US"
 * i.e. ignore all of Mozilla's various search engines in multiple locales ***/
user_pref("browser.search.geoSpecificDefaults", false);
user_pref("browser.search.geoSpecificDefaults.url", "");
/* 0207: set language to match ***/
user_pref("intl.accept_languages", "en-US, en");
/* 0208: enforce US English locale regardless of the system locale
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=867501 ***/
user_pref("javascript.use_us_english_locale", true); // (hidden pref)
/* 0209: use APP locale over OS locale in regional preferences (FF56+)
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1379420 [also 1364789] ***/
user_pref("intl.regional_prefs.use_os_locales", false);
/* 0210: use Mozilla geolocation service instead of Google when geolocation is enabled
 * Optionally enable logging to the console (defaults to false) ***/
user_pref("geo.wifi.uri", "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%");
   // user_pref("geo.wifi.logging.enabled", true); // (hidden pref)

/*** 0300: QUIET FOX
     We choose to not disable auto-CHECKs (0301's) but to disable auto-INSTALLs (0302's).
     There are many legitimate reasons to turn off auto-INSTALLS, including hijacked or
     monetized extensions, time constraints, legacy issues, and fear of breakage/bugs.
     It is still important to do updates for security reasons, please do so manually. ***/
user_pref("_user.js.parrot", "0300 syntax error: the parrot's not pinin' for the fjords!");
/* 0301a: disable auto-update checks for Firefox
 * [NOTE] Firefox currently checks every 12 hrs and allows 8 day notification dismissal
 * [SETTING-56+] Options>General>Firefox Updates>Never check for updates
 * [SETTING-ESR] Options>Advanced>Update>Never check for updates ***/
   // user_pref("app.update.enabled", false);
/* 0301b: disable auto-update checks for extensions
 * [SETTING] about:addons>Extensions>[cog-wheel-icon]>Update Add-ons Automatically (toggle) ***/
   // user_pref("extensions.update.enabled", false);
/* 0302a: disable auto update installing for Firefox (after the check in 0301a)
 * [SETTING-56+] Options>General>Firefox Updates>Check for updates but let you choose...
 * [SETTING-ESR] Options>Advanced>Update>Check for updates but let you choose...
 * [NOTE] The UI checkbox also controls the behavior for checking, the pref only controls auto installing ***/
user_pref("app.update.auto", false);
/* 0302b: disable auto update installing for extensions (after the check in 0301b)
 * [SETTING] about:addons>Extensions>[cog-wheel-icon]>Update Add-ons Automatically (toggle) ***/
user_pref("extensions.update.autoUpdateDefault", false);
/* 0303: disable background update service [WINDOWS]
 * [SETTING-56+] Options>General>Firefox Updates>Use a background service to install updates
 * [SETTING-ESR] Options>Advanced>Update>Use a background service to install updates ***/
user_pref("app.update.service.enabled", false);
/* 0304: disable background update staging ***/
user_pref("app.update.staging.enabled", false);
/* 0305: enforce update information is displayed
 * This is the update available, downloaded, error and success information ***/
user_pref("app.update.silent", false);
/* 0306: disable extension metadata updating
 * sends daily pings to Mozilla about extensions and recent startups ***/
user_pref("extensions.getAddons.cache.enabled", false);
/* 0307: disable auto updating of personas (themes) ***/
user_pref("lightweightThemes.update.enabled", false);
/* 0308: disable search update
 * [SETTING-56+] Options>General>Firefox Update>Automatically update search engines
 * [SETTING-ESR] Options>Advanced>Update>Automatically update: Search Engines ***/
user_pref("browser.search.update", false);
/* 0309: disable sending Flash crash reports ***/
user_pref("dom.ipc.plugins.flash.subprocess.crashreporter.enabled", false);
/* 0310: disable sending the URL of the website where a plugin crashed ***/
user_pref("dom.ipc.plugins.reportCrashURL", false);
/* 0320: disable about:addons' Get Add-ons panel (uses Google-Analytics) ***/
user_pref("extensions.getAddons.showPane", false); // hidden pref
user_pref("extensions.webservice.discoverURL", "");
/* 0330: disable telemetry
 * the pref (.unified) affects the behaviour of the pref (.enabled)
 * IF unified=false then .enabled controls the telemetry module
 * IF unified=true then .enabled ONLY controls whether to record extended data
 * so make sure to have both set as false
 * [NOTE] FF58+ `toolkit.telemetry.enabled` is now LOCKED to reflect prerelease
 * or release builds (true and false respectively), see [2]
 * [1] https://firefox-source-docs.mozilla.org/toolkit/components/telemetry/telemetry/internals/preferences.html
 * [2] https://medium.com/georg-fritzsche/data-preference-changes-in-firefox-58-2d5df9c428b5 ***/
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false); // see [NOTE] above FF58+
user_pref("toolkit.telemetry.server", "data:,");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.cachedClientID", "");
user_pref("toolkit.telemetry.newProfilePing.enabled", false); // (FF55+)
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false); // (FF55+)
user_pref("toolkit.telemetry.updatePing.enabled", false); // (FF56+)
user_pref("toolkit.telemetry.bhrPing.enabled", false); // (FF57+) Background Hang Reporter
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false); // (FF57+)
/* 0333a: disable health report ***/
user_pref("datareporting.healthreport.uploadEnabled", false);
/* 0333b: disable about:healthreport page (which connects to Mozilla for locale/css+js+json)
 * If you have disabled health reports, then this about page is useless - disable it
 * If you want to see what health data is present, then this must be set at default ***/
user_pref("datareporting.healthreport.about.reportUrl", "data:text/plain,");
/* 0334: disable new data submission, master kill switch (FF41+)
 * If disabled, no policy is shown or upload takes place, ever
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1195552 ***/
user_pref("datareporting.policy.dataSubmissionEnabled", false);
/* 0350: disable crash reports ***/
user_pref("breakpad.reportURL", "");
/* 0351: disable sending of crash reports (FF44+) ***/
user_pref("browser.tabs.crashReporting.sendReport", false);
user_pref("browser.crashReports.unsubmittedCheck.enabled", false); // (FF51+)
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit", false); // (FF51-57)
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false); // (FF58+)
/* 0360: disable new tab tile ads & preload & marketing junk ***/
user_pref("browser.newtab.preload", false);
user_pref("browser.newtabpage.directory.source", "data:text/plain,");
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.newtabpage.enhanced", false);
user_pref("browser.newtabpage.introShown", true);
/* 0370: disable "Snippets" (Mozilla content shown on about:home screen)
 * [1] https://wiki.mozilla.org/Firefox/Projects/Firefox_Start/Snippet_Service ***/
user_pref("browser.aboutHomeSnippets.updateUrl", "data:,");

/*** 0400: BLOCKLISTS / SAFE BROWSING / TRACKING PROTECTION
     This section has security & tracking protection implications vs privacy concerns vs effectiveness
     vs 3rd party 'censorship'. We DO NOT advocate no protection. If you disable Tracking Protection (TP)
     and/or Safe Browsing (SB), then SECTION 0400 REQUIRES YOU HAVE uBLOCK ORIGIN INSTALLED.

     Safe Browsing is designed to protect users from malicious sites. Tracking Protection is designed
     to lessen the impact of third parties on websites to reduce tracking and to speed up your browsing.
     These do rely on 3rd parties (Google for SB and Disconnect for TP), but many steps, which are
     continually being improved, have been taken to preserve privacy. Disable at your own risk.
***/
user_pref("_user.js.parrot", "0400 syntax error: the parrot's passed on!");
/** BLOCKLISTS ***/
/* 0401: enable Firefox blocklist, but sanitize blocklist url
 * [NOTE] It includes updates for "revoked certificates"
 * [1] https://blog.mozilla.org/security/2015/03/03/revoking-intermediate-certificates-introducing-onecrl/
 * [2] https://trac.torproject.org/projects/tor/ticket/16931 ***/
user_pref("extensions.blocklist.enabled", true);
user_pref("extensions.blocklist.url", "https://blocklists.settings.services.mozilla.com/v1/blocklist/3/%APP_ID%/%APP_VERSION%/");
/* 0402: enable Kinto blocklist updates (FF50+)
 * What is Kinto?: https://wiki.mozilla.org/Firefox/Kinto#Specifications
 * As Firefox transitions to Kinto, the blocklists have been broken down into entries for certs to be
 * revoked, extensions and plugins to be disabled, and gfx environments that cause problems or crashes ***/
user_pref("services.blocklist.update_enabled", true);
user_pref("services.blocklist.signing.enforced", true);
/* 0403: disable individual unwanted/unneeded parts of the Kinto blocklists ***/
   // user_pref("services.blocklist.onecrl.collection", ""); // revoked certificates
   // user_pref("services.blocklist.addons.collection", "");
   // user_pref("services.blocklist.plugins.collection", "");
   // user_pref("services.blocklist.gfx.collection", "");
/** SAFE BROWSING (SB)
    This sub-section has been redesigned to differentiate between "real-time"/"user initiated"
    data being sent to Google from all other settings such as using local blocklists/whitelists and
    updating those lists. There are NO privacy issues here. *IF* required, a full url is never sent
    to Google, only a PART-hash of the prefix, and this is hidden with noise of other real PART-hashes.
    Google also swear it is anonymized and only used to flag malicious sites/activity. Firefox
    also takes measures such as striping out identifying parameters and storing safe browsing
    cookies in a separate jar. (#Turn on browser.safebrowsing.debug to monitor this activity)
    #Required reading [#] https://feeding.cloud.geek.nz/posts/how-safe-browsing-works-in-firefox/
    [1] https://wiki.mozilla.org/Security/Safe_Browsing ***/
/* 0410: disable "Block dangerous and deceptive content" (under Options>Security)
 * This covers deceptive sites such as phishing and social engineering ***/
   // user_pref("browser.safebrowsing.malware.enabled", false);
   // user_pref("browser.safebrowsing.phishing.enabled", false); // (FF50+)
/* 0411: disable "Block dangerous downloads" (under Options>Security)
 * This covers malware and PUPs (potentially unwanted programs) ***/
   // user_pref("browser.safebrowsing.downloads.enabled", false);
/* 0412: disable "Warn me about unwanted and uncommon software" (under Options>Security) (FF48+) ***/
   // user_pref("browser.safebrowsing.downloads.remote.block_potentially_unwanted", false);
   // user_pref("browser.safebrowsing.downloads.remote.block_uncommon", false);
   // user_pref("browser.safebrowsing.downloads.remote.block_dangerous", false); // (FF49+)
   // user_pref("browser.safebrowsing.downloads.remote.block_dangerous_host", false); // (FF49+)
/* 0413: disable Google safebrowsing updates ***/
   // user_pref("browser.safebrowsing.provider.google.updateURL", "");
   // user_pref("browser.safebrowsing.provider.google.gethashURL", "");
   // user_pref("browser.safebrowsing.provider.google4.updateURL", ""); // (FF50+)
   // user_pref("browser.safebrowsing.provider.google4.gethashURL", ""); // (FF50+)
/* 0414: disable binaries NOT in local lists being checked by Google (real-time checking) ***/
user_pref("browser.safebrowsing.downloads.remote.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.url", "");
/* 0415: disable reporting URLs ***/
user_pref("browser.safebrowsing.provider.google.reportURL", "");
user_pref("browser.safebrowsing.reportPhishURL", "");
user_pref("browser.safebrowsing.provider.google4.reportURL", ""); // (FF50+)
user_pref("browser.safebrowsing.provider.google.reportMalwareMistakeURL", ""); // (FF54+)
user_pref("browser.safebrowsing.provider.google.reportPhishMistakeURL", ""); // (FF54+)
user_pref("browser.safebrowsing.provider.google4.reportMalwareMistakeURL", ""); // (FF54+)
user_pref("browser.safebrowsing.provider.google4.reportPhishMistakeURL", ""); // (FF54+)
/* 0416: disable 'ignore this warning' on Safe Browsing warnings which when clicked
 * bypasses the block for that session. This is a means for admins to enforce SB
 * [TEST] see github wiki APPENDIX C: Test Sites: Section 5
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1226490 ***/
   // user_pref("browser.safebrowsing.allowOverride", false);
/* 0417: disable data sharing (FF58+) ***/
user_pref("browser.safebrowsing.provider.google4.dataSharing.enabled", false);
user_pref("browser.safebrowsing.provider.google4.dataSharingURL", "");
/** TRACKING PROTECTION (TP)
    There are NO privacy concerns here, but we strongly recommend to use uBlock Origin as well,
    as it offers more comprehensive and specialized lists. It also allows per domain control. ***/
/* 0420: enable Tracking Protection in all windows
 * [NOTE] TP sends DNT headers regardless of the DNT pref (see 1610)
 * [1] https://wiki.mozilla.org/Security/Tracking_protection
 * [2] https://support.mozilla.org/kb/tracking-protection-firefox ***/
   // user_pref("privacy.trackingprotection.pbmode.enabled", true); // default true
   // user_pref("privacy.trackingprotection.enabled", true); // default false
/* 0421: enable more Tracking Protection choices under Options>Privacy>Use Tracking Protection
 * Displays three choices: "Always", "Only in private windows", "Never" ***/
user_pref("privacy.trackingprotection.ui.enabled", true);
/* 0422: enable "basic" or "strict" tracking protecting list - ONLY USE ONE!
 * [SETTING-56+] Options>Privacy & Security>Tracking Protection>Change Block List
 * [SETTING-ESR] Options>Privacy>Use Tracking Protection>Change Block List ***/
   // user_pref("urlclassifier.trackingTable", "test-track-simple,base-track-digest256"); // basic
   // user_pref("urlclassifier.trackingTable", "test-track-simple,base-track-digest256,content-track-digest256"); // strict
/* 0423: disable Mozilla's blocklist for known Flash tracking/fingerprinting (FF48+)
 * [1] https://www.ghacks.net/2016/07/18/firefox-48-blocklist-against-plugin-fingerprinting/
 * [2] https://bugzilla.mozilla.org/show_bug.cgi?id=1237198 ***/
   // user_pref("browser.safebrowsing.blockedURIs.enabled", false);
/* 0424: disable Mozilla's tracking protection and Flash blocklist updates ***/
   // user_pref("browser.safebrowsing.provider.mozilla.gethashURL", "");
   // user_pref("browser.safebrowsing.provider.mozilla.updateURL", "");
/* 0425: disable passive Tracking Protection (FF53+)
 * Passive TP annotates channels to lower the priority of network loads for resources on the tracking protection list
 * [NOTE] It has no effect if TP is enabled, but keep in mind that by default TP is only enabled in Private Windows
 * This is included for people who want to completely disable Tracking Protection.
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1170190
 * [2] https://bugzilla.mozilla.org/show_bug.cgi?id=1141814 ***/
   // user_pref("privacy.trackingprotection.annotate_channels", false);
   // user_pref("privacy.trackingprotection.lower_network_priority", false);

/*** 0500: SYSTEM EXTENSIONS / EXPERIMENTS
     System extensions are a method for shipping extensions, considered to be
     built-in features to Firefox, that are hidden from the about:addons UI.
     To view your system extensions go to about:support, they are listed under "Firefox Features"

     Some system extensions have no on-off prefs. Instead you can manually remove them. Note that app
     updates will restore them. They may also be updated and possibly restored automatically (see 0505)
     * Portable: "...\App\Firefox64\browser\features\" (or "App\Firefox\etc" for 32bit)
     * Windows: "...\Program Files\Mozilla\browser\features" (or "Program Files (X86)\etc" for 32bit)
     * Mac: "...\Applications\Firefox\Contents\Resources\browser\features\"
            [NOTE] On Mac you can right-click on the application and select "Show Package Contents"
     * Linux: "/usr/lib/firefox/browser/features" (or similar)

     [1] https://firefox-source-docs.mozilla.org/toolkit/mozapps/extensions/addon-manager/SystemAddons.html
     [2] https://dxr.mozilla.org/mozilla-central/source/browser/extensions
***/
user_pref("_user.js.parrot", "0500 syntax error: the parrot's cashed in 'is chips!");
/* 0501: disable experiments
 * [1] https://wiki.mozilla.org/Telemetry/Experiments ***/
user_pref("experiments.enabled", false);
user_pref("experiments.manifest.uri", "");
user_pref("experiments.supported", false);
user_pref("experiments.activeExperiment", false);
/* 0502: disable Mozilla permission to silently opt you into tests ***/
user_pref("network.allow-experiments", false);
/* 0505: block URL used for system extension updates (FF44+)
 * [NOTE] You will not get any system extension updates except when you update Firefox ***/
   // user_pref("extensions.systemAddon.update.url", "");
/* 0506: disable PingCentre telemetry (used in several system extensions) (FF57+)
 * Currently blocked by 'datareporting.healthreport.uploadEnabled' (see 0333) ***/
user_pref("browser.ping-centre.telemetry", false);
/* 0510: disable Pocket (FF39+)
 * Pocket is a third party (now owned by Mozilla) "save for later" cloud service
 * [1] https://en.wikipedia.org/wiki/Pocket_(application)
 * [2] https://www.gnu.gl/blog/Posts/multiple-vulnerabilities-in-pocket/ ***/
user_pref("extensions.pocket.enabled", false);
/* 0511: disable FlyWeb (FF49+)
 * Flyweb is a set of APIs for advertising and discovering local-area web servers
 * [1] https://flyweb.github.io/
 * [2] https://wiki.mozilla.org/FlyWeb/Security_scenarios
 * [3] https://www.ghacks.net/2016/07/26/firefox-flyweb/ ***/
user_pref("dom.flyweb.enabled", false);
/* 0512: disable Shield (FF53+)
 * Shield is an telemetry system (including Heartbeat) that can also push and test "recipes"
 * [1] https://wiki.mozilla.org/Firefox/Shield
 * [2] https://github.com/mozilla/normandy ***/
user_pref("extensions.shield-recipe-client.enabled", false);
user_pref("extensions.shield-recipe-client.api_url", "");
/* 0513: disable Follow On Search (FF53+)
 * Just DELETE the XPI file in your system extensions directory
 * [1] https://blog.mozilla.org/data/2017/06/05/measuring-search-in-firefox/ ***/
/* 0514: disable Activity Stream (FF54+)
 * Activity Stream replaces "New Tab" with one based on metadata and browsing behavior,
 * and includes telemetry as well as web content such as snippets and "spotlight"
 * [1] https://wiki.mozilla.org/Firefox/Activity_Stream
 * [2] https://www.ghacks.net/2016/02/15/firefox-mockups-show-activity-stream-new-tab-page-and-share-updates/ ***/
user_pref("browser.newtabpage.activity-stream.enabled", false);
user_pref("browser.library.activity-stream.enabled", false); // (FF57+)
/* 0515: disable Screenshots (FF55+)
 * [1] https://github.com/mozilla-services/screenshots
 * [2] https://www.ghacks.net/2017/05/28/firefox-screenshots-integrated-in-firefox-nightly/ ***/
   // user_pref("extensions.screenshots.disabled", true);
/* 0516: disable Onboarding (FF55+)
 * Onboarding is an interactive tour/setup for new installs/profiles and features. Every time
 * about:home or about:newtab is opened, the onboarding overlay is injected into that page
 * [NOTE] Onboarding uses Google Analytics [2], and leaks resource://URIs [3]
 * [1] https://wiki.mozilla.org/Firefox/Onboarding
 * [2] https://github.com/mozilla/onboard/commit/db4d6c8726c89a5d6a241c1b1065827b525c5baf
 * [3] https://bugzilla.mozilla.org/show_bug.cgi?id=863246#c154 ***/
user_pref("browser.onboarding.enabled", false);
/* 0517: disable Form Autofill (FF55+)
 * [SETTING-56+] Options>Privacy & Security>Forms & Passwords>Enable Profile Autofill
 * [SETTING-ESR] Options>Privacy>Forms & Passwords>Enable Profile Autofill
 * [NOTE] Stored data is NOT secure (uses a JSON file)
 * [NOTE] Heuristics controls Form Autofill on forms without @autocomplete attributes
 * [1] https://wiki.mozilla.org/Firefox/Features/Form_Autofill
 * [2] https://www.ghacks.net/2017/05/24/firefoxs-new-form-autofill-is-awesome/ ***/
user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.available", "off"); // (FF56+)
user_pref("extensions.formautofill.creditCards.enabled", false); // (FF56+)
user_pref("extensions.formautofill.heuristics.enabled", false);
/* 0518: disable Web Compatibility Reporter (FF56+)
 * Web Compatibility Reporter adds a "Report Site Issue" button to send data to Mozilla ***/
user_pref("extensions.webcompat-reporter.enabled", false);

/*** 0600: BLOCK IMPLICIT OUTBOUND [not explicitly asked for - e.g. clicked on] ***/
user_pref("_user.js.parrot", "0600 syntax error: the parrot's no more!");
/* 0601: disable link prefetching
 * [1] https://developer.mozilla.org/docs/Web/HTTP/Link_prefetching_FAQ ***/
user_pref("network.prefetch-next", false);
/* 0602: disable DNS prefetching
 * [1] https://www.ghacks.net/2013/04/27/firefox-prefetching-what-you-need-to-know/
 * [2] https://developer.mozilla.org/docs/Web/HTTP/Headers/X-DNS-Prefetch-Control ***/
user_pref("network.dns.disablePrefetch", true);
user_pref("network.dns.disablePrefetchFromHTTPS", true); // (hidden pref)
/* 0603a: disable Seer/Necko
 * [1] https://developer.mozilla.org/docs/Mozilla/Projects/Necko ***/
user_pref("network.predictor.enabled", false);
/* 0603b: disable more Necko/Captive Portal
 * [1] https://en.wikipedia.org/wiki/Captive_portal
 * [2] https://wiki.mozilla.org/Necko/CaptivePortal
 * [3] https://trac.torproject.org/projects/tor/ticket/21790 ***/
user_pref("captivedetect.canonicalURL", "");
user_pref("network.captive-portal-service.enabled", false); // (FF52+)
/* 0605: disable link-mouseover opening connection to linked server
 * [1] https://news.slashdot.org/story/15/08/14/2321202/how-to-quash-firefoxs-silent-requests
 * [2] https://www.ghacks.net/2015/08/16/block-firefox-from-connecting-to-sites-when-you-hover-over-links/ ***/
user_pref("network.http.speculative-parallel-limit", 0);
/* 0606: disable pings (but enforce same host in case)
 * [1] http://kb.mozillazine.org/Browser.send_pings
 * [2] http://kb.mozillazine.org/Browser.send_pings.require_same_host ***/
user_pref("browser.send_pings", false);
user_pref("browser.send_pings.require_same_host", true);
/* 0607: disable links launching Windows Store on Windows 8/8.1/10 [WINDOWS]
 * [1] https://www.ghacks.net/2016/03/25/block-firefox-chrome-windows-store/ ***/
user_pref("network.protocol-handler.external.ms-windows-store", false);
/* 0608: disable predictor / prefetching (FF48+) ***/
user_pref("network.predictor.enable-prefetch", false);

/*** 0800: LOCATION BAR / SEARCH BAR / SUGGESTIONS / HISTORY / FORMS [SETUP]
     If you are in a private environment (no unwanted eyeballs) and your device is private
     (restricted access), and the device is secure when unattended (locked, encrypted, forensic
     hardened), then items 0850 and above can be relaxed in return for more convenience and
     functionality. Likewise, you may want to check the items cleared on shutdown in section 2800.
     [NOTE] The urlbar is also commonly referred to as the location bar and address bar
     #Required reading [#] https://xkcd.com/538/
 ***/
user_pref("_user.js.parrot", "0800 syntax error: the parrot's ceased to be!");
/* 0801: disable location bar using search - PRIVACY
 * don't leak typos to a search engine, give an error message instead ***/
user_pref("keyword.enabled", false);
/* 0802: disable location bar domain guessing - PRIVACY/SECURITY
 * domain guessing intercepts DNS "hostname not found errors" and resends a
 * request (e.g. by adding www or .com). This is inconsistent use (e.g. FQDNs), does not work
 * via Proxy Servers (different error), is a flawed use of DNS (TLDs: why treat .com
 * as the 411 for DNS errors?), privacy issues (why connect to sites you didn't
 * intend to), can leak sensitive data (e.g. query strings: e.g. Princeton attack),
 * and is a security risk (e.g. common typos & malicious sites set up to exploit this) ***/
user_pref("browser.fixup.alternate.enabled", false);
/* 0803: display all parts of the url in the location bar - helps SECURITY ***/
user_pref("browser.urlbar.trimURLs", false);
/* 0804: limit history leaks via enumeration (PER TAB: back/forward) - PRIVACY
 * This is a PER TAB session history. You still have a full history stored under all history
 * default=50, minimum=1=currentpage, 2 is the recommended minimum as some pages
 * use it as a means of referral (e.g. hotlinking), 4 or 6 or 10 may be more practical ***/
user_pref("browser.sessionhistory.max_entries", 10);
/* 0805: disable CSS querying page history - CSS history leak - PRIVACY
 * [NOTE] This has NEVER been fully "resolved": in Mozilla/docs it is stated it's
 * only in 'certain circumstances', also see latest comments in [2]
 * [TEST] http://lcamtuf.coredump.cx/yahh/ (see github wiki APPENDIX C on how to use)
 * [1] https://dbaron.org/mozilla/visited-privacy
 * [2] https://bugzilla.mozilla.org/show_bug.cgi?id=147777
 * [3] https://developer.mozilla.org/docs/Web/CSS/Privacy_and_the_:visited_selector ***/
user_pref("layout.css.visited_links_enabled", false);
/* 0806: disable displaying javascript in history URLs - SECURITY ***/
user_pref("browser.urlbar.filter.javascript", true);
/* 0807: disable search bar LIVE search suggestions - PRIVACY
 * [SETTING] Options>Search>Provide search suggestions ***/
user_pref("browser.search.suggest.enabled", false);
/* 0808: disable location bar LIVE search suggestions (requires 0807 = true) - PRIVACY
 * Also disable the location bar prompt to enable/disable or learn more about it.
 * [SETTING] Options>Search>Show search suggestions in address bar results ***/
user_pref("browser.urlbar.suggest.searches", false);
user_pref("browser.urlbar.userMadeSearchSuggestionsChoice", true); // (FF41+)
/* 0809: disable location bar suggesting "preloaded" top websites (FF54+)
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1211726 ***/
user_pref("browser.urlbar.usepreloadedtopurls.enabled", false);
/* 0810: disable location bar making speculative connections (FF56+)
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1348275 ***/
user_pref("browser.urlbar.speculativeConnect.enabled", false);
/* 0850a: disable location bar autocomplete and suggestion types
 * If you enforce any of the suggestion types, you MUST enforce 'autocomplete'
 *   - If *ALL* of the suggestion types are false, 'autocomplete' must also be false
 *   - If *ANY* of the suggestion types are true, 'autocomplete' must also be true
 * [SETTING-56+] Options>Privacy & Security>Address Bar>When using the address bar, suggest
 * [SETTING-ESR] Options>Privacy>Location Bar>When using the location bar, suggest
 * [WARNING] If all three suggestion types are false, search engine keywords are disabled ***/
user_pref("browser.urlbar.autocomplete.enabled", false);
user_pref("browser.urlbar.suggest.history", false);
user_pref("browser.urlbar.suggest.bookmark", false);
user_pref("browser.urlbar.suggest.openpage", false);
/* 0850c: disable location bar dropdown
 * This value controls the total number of entries to appear in the location bar dropdown
 * [NOTE] Items (bookmarks/history/openpages) with a high "frecency"/"bonus" will always
 * be displayed (no we do not know how these are calculated or what the threshold is),
 * and this does not affect the search by search engine suggestion (see 0808)
 * [USAGE] This setting is only useful if you want to enable search engine keywords
 * (i.e. at least one of 0850a suggestion types must be true) but you want to *limit* suggestions shown ***/
   // user_pref("browser.urlbar.maxRichResults", 0);
/* 0850d: disable location bar autofill
 * [1] http://kb.mozillazine.org/Inline_autocomplete ***/
user_pref("browser.urlbar.autoFill", false);
user_pref("browser.urlbar.autoFill.typed", false);
/* 0850e: disable location bar one-off searches (FF51+)
 * [1] https://www.ghacks.net/2016/08/09/firefox-one-off-searches-address-bar/ ***/
user_pref("browser.urlbar.oneOffSearches", false);
/* 0850f: disable location bar suggesting local search history (FF57+)
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1181644 ***/
user_pref("browser.urlbar.maxHistoricalSearchSuggestions", 0); // max. number of search suggestions
/* 0860: disable search and form history
 * [SETTING-56+] Options>Privacy & Security>History>Custom Settings>Remember search and form history
 * [SETTING-ESR] Options>Privacy>History>Custom Settings>Remember search and form history
 * [NOTE] You can clear formdata on exiting Firefox (see 2803) ***/
user_pref("browser.formfill.enable", false);
/* 0862: disable browsing and download history
 * [SETTING-56+] Options>Privacy & Security>History>Custom Settings>Remember my browsing and download history
 * [SETTING-ESR] Options>Privacy>History>Custom Settings>Remember my browsing and download history
 * [NOTE] You can clear history and downloads on exiting Firefox (see 2803) ***/
   // user_pref("places.history.enabled", false);
/* 0870: disable Windows jumplist [WINDOWS] ***/
user_pref("browser.taskbar.lists.enabled", false);
user_pref("browser.taskbar.lists.frequent.enabled", false);
user_pref("browser.taskbar.lists.recent.enabled", false);
user_pref("browser.taskbar.lists.tasks.enabled", false);
/* 0871: disable Windows taskbar preview [WINDOWS] ***/
user_pref("browser.taskbar.previews.enable", false);

/*** 0900: PASSWORDS ***/
user_pref("_user.js.parrot", "0900 syntax error: the parrot's expired!");
/* 0901: disable saving passwords
 * [SETTING-56+] Options>Privacy & Security>Forms & Passwords>Remember logins and passwords for sites
 * [SETTING-ESR] Options>Security>Logins>Remember logins for sites
 * [NOTE] This does not clear any passwords already saved ***/
   // user_pref("signon.rememberSignons", false);
/* 0902: use a master password (recommended if you save passwords)
 * There are no preferences for this. It is all handled internally.
 * [SETTING-56+] Options>Privacy & Security>Forms & Passwords>Use a master password
 * [SETTING-ESR] Options>Security>Logins>Use a master password
 * [1] https://support.mozilla.org/kb/use-master-password-protect-stored-logins ***/
/* 0903: set how often Firefox should ask for the master password
 * 0=the first time (default), 1=every time it's needed, 2=every n minutes (as per the next pref) ***/
user_pref("security.ask_for_password", 2);
/* 0904: set how often in minutes Firefox should ask for the master password (see pref above)
 * in minutes, default is 30 ***/
user_pref("security.password_lifetime", 5);
/* 0905: disable auto-filling username & password form fields - SECURITY
 * can leak in cross-site forms AND be spoofed
 * [NOTE] Password will still be auto-filled after a user name is manually entered
 * [1] http://kb.mozillazine.org/Signon.autofillForms ***/
user_pref("signon.autofillForms", false);
/* 0906: disable websites' autocomplete="off" (FF30+)
 * Don't let sites dictate use of saved logins and passwords. Increase security through
 * stronger password use. The trade-off is the convenience. Some sites should never be
 * saved (such as banking sites). Set at true, informed users can make their own choice. ***/
user_pref("signon.storeWhenAutocompleteOff", true);
/* 0907: display warnings for logins on non-secure (non HTTPS) pages
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1217156 ***/
user_pref("security.insecure_password.ui.enabled", true);
/* 0908: remove user & password info when attempting to fix an entered URL (i.e. 0802 is true)
 * e.g. //user:password@foo -> //user@(prefix)foo(suffix) NOT //user:password@(prefix)foo(suffix) ***/
user_pref("browser.fixup.hide_user_pass", true);
/* 0909: disable formless login capture for Password Manager (FF51+) ***/
user_pref("signon.formlessCapture.enabled", false);
/* 0910: disable autofilling saved passwords on HTTP pages and show warning (FF52+)
 * [1] https://www.fxsitecompat.com/en-CA/docs/2017/insecure-login-forms-now-disable-autofill-show-warning-beneath-input-control/
 * [2] https://bugzilla.mozilla.org/show_bug.cgi?id=1217152
 * [3] https://bugzilla.mozilla.org/show_bug.cgi?id=1319119 ***/
user_pref("signon.autofillForms.http", false);
user_pref("security.insecure_field_warning.contextual.enabled", true);
/* 0911: prevent cross-origin images from triggering an HTTP-Authentication prompt (FF55+)
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1357835 ***/
user_pref("network.auth.subresource-img-cross-origin-http-auth-allow", false);

/*** 1000: CACHE [SETUP] ***/
user_pref("_user.js.parrot", "1000 syntax error: the parrot's gone to meet 'is maker!");
/** CACHE ***/
/* 1001: disable disk cache ***/
user_pref("browser.cache.disk.enable", false);
user_pref("browser.cache.disk.capacity", 0);
user_pref("browser.cache.disk.smart_size.enabled", false);
user_pref("browser.cache.disk.smart_size.first_run", false);
/* 1002: disable disk cache for SSL pages
 * [1] http://kb.mozillazine.org/Browser.cache.disk_cache_ssl ***/
user_pref("browser.cache.disk_cache_ssl", false);
/* 1003: disable memory cache
 * [NOTE] Not recommended due to performance issues ***/
   // user_pref("browser.cache.memory.enable", false);
   // user_pref("browser.cache.memory.capacity", 0); // (hidden pref)
/* 1005: disable fastback cache
 * To improve performance when pressing back/forward Firefox stores visited pages
 * so they don't have to be re-parsed. This is not the same as memory cache.
 * 0=none, -1=auto (that's minus 1), or for other values see [1]
 * [NOTE] Not recommended unless you know what you're doing
 * [1] http://kb.mozillazine.org/Browser.sessionhistory.max_total_viewers ***/
   // user_pref("browser.sessionhistory.max_total_viewers", 0);
/* 1006: disable permissions manager from writing to disk [RESTART]
 * [NOTE] This means any permission changes are session only
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=967812 ***/
   // user_pref("permissions.memory_only", true); // (hidden pref)
/* 1007: disable randomized FF HTTP cache decay experiments
 * [1] https://trac.torproject.org/projects/tor/ticket/13575 ***/
user_pref("browser.cache.frecency_experiment", -1);
/* 1008: set DNS cache and expiration time (default 400 and 60, same as TBB) ***/
   // user_pref("network.dnsCacheEntries", 400);
   // user_pref("network.dnsCacheExpiration", 60);
/** SESSIONS & SESSION RESTORE ***/
/* 1020: disable the Session Restore service completely
 * [WARNING] [SETUP] This also disables the "Recently Closed Tabs" feature
 * It does not affect "Recently Closed Windows" or any history. ***/
user_pref("browser.sessionstore.max_tabs_undo", 0);
user_pref("browser.sessionstore.max_windows_undo", 0);
/* 1021: disable storing extra session data
 * extra session data contains contents of forms, scrollbar positions, cookies and POST data
 * define on which sites to save extra session data:
 * 0=everywhere, 1=unencrypted sites, 2=nowhere ***/
user_pref("browser.sessionstore.privacy_level", 2);
/* 1022: disable resuming session from crash [SETUP] ***/
user_pref("browser.sessionstore.resume_from_crash", false);
/* 1023: set the minimum interval between session save operations - increasing it
 * can help on older machines and some websites, as well as reducing writes, see [1]
 * Default is 15000 (15 secs). Try 30000 (30sec), 60000 (1min) etc
 * [WARNING] This can also affect entries in the "Recently Closed Tabs" feature:
 * i.e. the longer the interval the more chance a quick tab open/close won't be captured.
 * This longer interval *may* affect history but we cannot replicate any history not recorded
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1304389 ***/
user_pref("browser.sessionstore.interval", 30000);
/** FAVICONS ***/
/* 1030: disable favicons in shortcuts
 * URL shortcuts use a cached randomly named .ico file which is stored in your
 * profile/shortcutCache directory. The .ico remains after the shortcut is deleted.
 * If set to false then the shortcuts use a generic Firefox icon ***/
user_pref("browser.shell.shortcutFavicons", false);
/* 1031: disable favicons in tabs and new bookmarks
 * bookmark favicons are stored as data blobs in places.sqlite>moz_favicons ***/
   // user_pref("browser.chrome.site_icons", false);
   // user_pref("browser.chrome.favicons", false);
/* 1032: disable favicons in web notifications ***/
user_pref("alerts.showFavicons", false); // default: false

/*** 1200: HTTPS ( SSL/TLS / OCSP / CERTS / HSTS / HPKP / CIPHERS )
   Note that your cipher and other settings can be used server side as a fingerprint attack
   vector, see [1] (It's quite technical but the first part is easy to understand
   and you can stop reading when you reach the second section titled "Enter Bro")

   Option 1: Use Firefox defaults for the 1260's items (item 1260 default for SHA-1, is local
             only anyway). There is nothing *weak* about Firefox's defaults, but Mozilla (and
             other browsers) will always lag for fear of breakage and upset end-users
   Option 2: Disable the ciphers in 1261, 1262 and 1263. These shouldn't break anything.
             Optionally, disable the ciphers in 1264.

   [1] https://www.securityartwork.es/2017/02/02/tls-client-fingerprinting-with-bro/
 ***/
user_pref("_user.js.parrot", "1200 syntax error: the parrot's a stiff!");
/** SSL (Secure Sockets Layer) / TLS (Transport Layer Security) ***/
/* 1201: disable old SSL/TLS - vulnerable to a MiTM attack
 * [WARNING] Tested Feb 2017 - still breaks too many sites
 * [1] https://wiki.mozilla.org/Security:Renegotiation ***/
   // user_pref("security.ssl.require_safe_negotiation", true);
/* 1202: control TLS versions with min and max
 * 1=min version of TLS 1.0, 2=min version of TLS 1.1, 3=min version of TLS 1.2 etc
 * [NOTE] Jul-2017: Telemetry indicates approx 2% of TLS web traffic uses 1.0 or 1.1
 * [WARNING] If you get an "SSL_ERROR_NO_CYPHER_OVERLAP" error, temporarily
 * set a lower value for 'security.tls.version.min' in about:config
 * [1] http://kb.mozillazine.org/Security.tls.version.*
 * [2] https://www.ssl.com/how-to/turn-off-ssl-3-0-and-tls-1-0-in-your-browser/
 * [2] archived: https://archive.is/hY2Mm ***/
user_pref("security.tls.version.min", 3);
user_pref("security.tls.version.fallback-limit", 3);
user_pref("security.tls.version.max", 4); // 4 = allow up to and including TLS 1.3
/* 1203: disable SSL session tracking (FF36+)
 * SSL Session IDs speed up HTTPS connections (no need to renegotiate) and last for 48hrs.
 * Since the ID is unique, web servers can (and do) use it for tracking. If set to true,
 * this disables sending SSL Session IDs and TLS Session Tickets to prevent session tracking
 * [1] https://tools.ietf.org/html/rfc5077
 * [2] https://bugzilla.mozilla.org/show_bug.cgi?id=967977 ***/
user_pref("security.ssl.disable_session_identifiers", true); // (hidden pref)
/* 1204: disable SSL Error Reporting
 * [1] https://firefox-source-docs.mozilla.org/browser/base/sslerrorreport/preferences.html ***/
user_pref("security.ssl.errorReporting.automatic", false);
user_pref("security.ssl.errorReporting.enabled", false);
user_pref("security.ssl.errorReporting.url", "");
/* 1205: disable TLS1.3 0-RTT (round-trip time) (FF51+)
 * [1] https://github.com/tlswg/tls13-spec/issues/1001
 * [2] https://blog.cloudflare.com/tls-1-3-overview-and-q-and-a/ ***/
user_pref("security.tls.enable_0rtt_data", false); // (FF55+ default true)
/** OCSP (Online Certificate Status Protocol)
    #Required reading [#] https://scotthelme.co.uk/revocation-is-broken/ ***/
/* 1210: enable OCSP Stapling
 * [1] https://blog.mozilla.org/security/2013/07/29/ocsp-stapling-in-firefox/ ***/
user_pref("security.ssl.enable_ocsp_stapling", true);
/* 1211: control when to use OCSP fetching (to confirm current validity of certificates)
 * 0=disabled, 1=enabled (default), 2=enabled for EV certificates only
 * OCSP (non-stapled) leaks information about the sites you visit to the CA (cert authority)
 * It's a trade-off between security (checking) and privacy (leaking info to the CA)
 * [NOTE] This pref only controls OCSP fetching and does not affect OCSP stapling
 * [1] https://en.wikipedia.org/wiki/Ocsp ***/
user_pref("security.OCSP.enabled", 1);
/* 1212: set OCSP fetch failures (non-stapled, see 1211) to hard-fail
 * When a CA cannot be reached to validate a cert, Firefox just continues the connection (=soft-fail)
 * Setting this pref to true tells Firefox to instead terminate the connection (=hard-fail)
 * It is pointless to soft-fail when an OCSP fetch fails: you cannot confirm a cert is still valid (it
 * could have been revoked) and/or you could be under attack (e.g. malicious blocking of OCSP servers)
 * [1] https://blog.mozilla.org/security/2013/07/29/ocsp-stapling-in-firefox/
 * [2] https://www.imperialviolet.org/2014/04/19/revchecking.html ***/
user_pref("security.OCSP.require", true);
/** CERTS / HSTS (HTTP Strict Transport Security) / HPKP (HTTP Public Key Pinning) ***/
/* 1220: disable Windows 8.1's Microsoft Family Safety cert [WINDOWS] (FF50+)
 * 0=disable detecting Family Safety mode and importing the root
 * 1=only attempt to detect Family Safety mode (don't import the root)
 * 2=detect Family Safety mode and import the root
 * [1] https://trac.torproject.org/projects/tor/ticket/21686 ***/
user_pref("security.family_safety.mode", 0);
/* 1221: disable intermediate certificate caching (fingerprinting attack vector) [RESTART]
 * [NOTE] This may be better handled under FPI (ticket 1323644, part of Tor Uplift)
 * [WARNING] This affects login/cert/key dbs. The effect is all credentials are session-only.
 * Saved logins and passwords are not available. Reset the pref and restart to return them.
 * [TEST] https://fiprinca.0x90.eu/poc/
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1334485 - related bug
 * [2] https://bugzilla.mozilla.org/show_bug.cgi?id=1216882 - related bug (see comment 9) ***/
   // user_pref("security.nocertdb", true); // (hidden pref)
/* 1222: enforce strict pinning
 * PKP (Public Key Pinning) 0=disabled 1=allow user MiTM (such as your antivirus), 2=strict
 * [WARNING] If you rely on an AV (antivirus) to protect your web browsing
 * by inspecting ALL your web traffic, then leave at current default=1
 * [1] https://trac.torproject.org/projects/tor/ticket/16206 ***/
user_pref("security.cert_pinning.enforcement_level", 2);
/* 1223: enforce HSTS preload list (default is true)
 * The list is compiled into Firefox and used to always load those domains over HTTPS
 * [1] https://blog.mozilla.org/security/2012/11/01/preloading-hsts/
 * [2] https://wiki.mozilla.org/Privacy/Features/HSTS_Preload_List ***/
user_pref("network.stricttransportsecurity.preloadlist", true);
/** MIXED CONTENT ***/
/* 1240: disable insecure active content on https pages - mixed content
 * [1] https://trac.torproject.org/projects/tor/ticket/21323 ***/
user_pref("security.mixed_content.block_active_content", true);
/* 1241: disable insecure passive content (such as images) on https pages - mixed context ***/
user_pref("security.mixed_content.block_display_content", true);
/* 1242: enable Mixed-Content-Blocker to use the HSTS cache but disable the HSTS Priming requests (FF51+)
 * Allow resources from domains with an existing HSTS cache record or in the HSTS preload list
 * to be upgraded to HTTPS internally but disable sending out HSTS Priming requests, because
 * those may cause noticeable delays e.g. requests time out or are not handled well by servers
 * [NOTE] If you want to use the priming requests make sure 'use_hsts' is also true
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1246540#c145 ***/
user_pref("security.mixed_content.use_hsts", true);
user_pref("security.mixed_content.send_hsts_priming", false);
/** CIPHERS [see the section 1200 intro] ***/
/* 1260: disable or limit SHA-1
 * 0=all SHA1 certs are allowed
 * 1=all SHA1 certs are blocked (including perfectly valid ones from 2015 and earlier)
 * 2=deprecated option that now maps to 1
 * 3=only allowed for locally-added roots (e.g. anti-virus)
 * 4=only allowed for locally-added roots or for certs in 2015 and earlier
 * [WARNING] When disabled, some man-in-the-middle devices (e.g. security scanners and
 * antivirus products, may fail to connect to HTTPS sites. SHA-1 is *almost* obsolete.
 * [1] https://blog.mozilla.org/security/2016/10/18/phasing-out-sha-1-on-the-public-web/ ***/
user_pref("security.pki.sha1_enforcement_level", 1);
/* 1261: disable 3DES (effective key size < 128)
 * [1] https://en.wikipedia.org/wiki/3des#Security
 * [2] http://en.citizendium.org/wiki/Meet-in-the-middle_attack
 * [3] https://www-archive.mozilla.org/projects/security/pki/nss/ssl/fips-ssl-ciphersuites.html ***/
   // user_pref("security.ssl3.rsa_des_ede3_sha", false);
/* 1262: disable 128 bits ***/
   // user_pref("security.ssl3.ecdhe_ecdsa_aes_128_sha", false);
   // user_pref("security.ssl3.ecdhe_rsa_aes_128_sha", false);
/* 1263: disable DHE (Diffie-Hellman Key Exchange)
 * [WARNING] May break obscure sites, but not major sites, which should support ECDH over DHE
 * [1] https://www.eff.org/deeplinks/2015/10/how-to-protect-yourself-from-nsa-attacks-1024-bit-DH ***/
   // user_pref("security.ssl3.dhe_rsa_aes_128_sha", false);
   // user_pref("security.ssl3.dhe_rsa_aes_256_sha", false);
/* 1264: disable the remaining non-modern cipher suites as of FF52
 * [NOTE] Commented out because it still breaks too many sites ***/
   // user_pref("security.ssl3.rsa_aes_128_sha", false);
   // user_pref("security.ssl3.rsa_aes_256_sha", false);
/** UI (User Interface) ***/
/* 1270: display warning (red padlock) for "broken security"
 * [1] https://wiki.mozilla.org/Security:Renegotiation ***/
user_pref("security.ssl.treat_unsafe_negotiation_as_broken", true);
/* 1271: control "Add Security Exception" dialog on SSL warnings
 * 0=do neither 1=pre-populate url 2=pre-populate url + pre-fetch cert (default)
 * [1] https://github.com/pyllyukko/user.js/issues/210 ***/
user_pref("browser.ssl_override_behavior", 1);
/* 1272: display advanced information on Insecure Connection warning pages
 * only works when it's possible to add an exception
 * i.e. it doesn't work for HSTS discrepancies (https://subdomain.preloaded-hsts.badssl.com/)
 * [TEST] https://expired.badssl.com/ ***/
user_pref("browser.xul.error_pages.expert_bad_cert", true);
/* 1273: display HTTP sites as insecure (FF59+) ***/
user_pref("security.insecure_connection_icon.enabled", true); // all windows
   // user_pref("security.insecure_connection_icon.pbmode.enabled", true); // private windows only

/*** 1400: FONTS ***/
user_pref("_user.js.parrot", "1400 syntax error: the parrot's bereft of life!");
/* 1401: disable websites choosing fonts (0=block, 1=allow)
 * If you disallow fonts, this drastically limits/reduces font
 * enumeration (by JS) which is a high entropy fingerprinting vector.
 * [SETTING-56+] Options>General>Language and Appearance>Advanced>Allow pages to choose...
 * [SETTING-ESR] Options>Content>Font & Colors>Advanced>Allow pages to choose...
 * [SETUP] Disabling fonts can uglify the web a fair bit. ***/
user_pref("browser.display.use_document_fonts", 0);
/* 1402: set more legible default fonts [SETUP]
 * [SETTING-56+] Options>General>Language and Appearance>Fonts & Colors>Advanced>Serif|Sans-serif|Monospace
 * [SETTING-ESR] Options>Fonts & Colors>Advanced>Serif|Sans-serif|Monospace
 * [NOTE] Example below for Windows/Western only ***/
   // user_pref("font.name.serif.x-unicode", "Georgia");
   // user_pref("font.name.serif.x-western", "Georgia"); // default Times New Roman
   // user_pref("font.name.sans-serif.x-unicode", "Arial");
   // user_pref("font.name.sans-serif.x-western", "Arial"); // default Arial
   // user_pref("font.name.monospace.x-unicode", "Lucida Console");
   // user_pref("font.name.monospace.x-western", "Lucida Console"); // default Courier New
/* 1403: enable icon fonts (glyphs) (FF41+)
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=789788 ***/
user_pref("gfx.downloadable_fonts.enabled", true); // default: true
/* 1404: disable rendering of SVG OpenType fonts
 * [1] https://wiki.mozilla.org/SVGOpenTypeFonts - iSECPartnersReport recommends to disable this ***/
user_pref("gfx.font_rendering.opentype_svg.enabled", false);
/* 1405: disable WOFF2 (Web Open Font Format) (FF35+) ***/
user_pref("gfx.downloadable_fonts.woff2.enabled", false);
/* 1406: disable CSS Font Loading API
 * [SETUP] Disabling fonts can uglify the web a fair bit. ***/
user_pref("layout.css.font-loading-api.enabled", false);
/* 1407: disable special underline handling for a few fonts which you will probably never use [RESTART]
 * Any of these fonts on your system can be enumerated for fingerprinting.
 * [1] http://kb.mozillazine.org/Font.blacklist.underline_offset ***/
user_pref("font.blacklist.underline_offset", "");
/* 1408: disable graphite which FF49 turned back on by default
 * In the past it had security issues. Update: This continues to be the case, see [1]
 * [1] https://www.mozilla.org/security/advisories/mfsa2017-15/#CVE-2017-7778 ***/
user_pref("gfx.font_rendering.graphite.enabled", false);
/* 1409: limit system font exposure to a whitelist (FF52+) [SETUP] [RESTART]
 * If the whitelist is empty, then whitelisting is considered disabled and all fonts are allowed.
 * [NOTE] Creating your own probably highly-unique whitelist will raise your entropy. If
 * you block sites choosing fonts in 1401, this preference is irrelevant. In future,
 * privacy.resistFingerprinting (see 4500) may cover this, and 1401 can be relaxed.
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1121643 ***/
   // user_pref("font.system.whitelist", ""); // (hidden pref)

/*** 1600: HEADERS / REFERERS
     Only *cross domain* referers need controlling and XOriginPolicy (1603) is perfect for that. Thus we enforce
     the default values for 1601, 1602, 1605 and 1606 to minimize breakage, and only tweak 1603 and 1604.

     Our default settings provide the best balance between protection and amount of breakage.
     To harden it a bit more you can set XOriginPolicy (1603) to 2 (+ optionally 1604 to 1 or 2).
     To fix broken sites, temporarily set XOriginPolicy=0 and XOriginTrimmingPolicy=2 in about:config,
     use the site and then change the values back. If you visit those sites regularly, use an extension.

                    full URI: https://example.com:8888/foo/bar.html?id=1234
       scheme+host+path+port: https://example.com:8888/foo/bar.html
            scheme+host+port: https://example.com:8888

     #Required reading [#] https://feeding.cloud.geek.nz/posts/tweaking-referrer-for-privacy-in-firefox/
 ***/
user_pref("_user.js.parrot", "1600 syntax error: the parrot rests in peace!");
/* 1601: ALL: control when images/links send a referer
 * 0=never, 1=send only when links are clicked, 2=for links and images (default) ***/
user_pref("network.http.sendRefererHeader", 2);
/* 1602: ALL: control the amount of information to send
 * 0=send full URI (default), 1=scheme+host+path+port, 2=scheme+host+port ***/
user_pref("network.http.referer.trimmingPolicy", 0);
/* 1603: CROSS ORIGIN: control when to send a referer [SETUP]
 * 0=always (default), 1=only if base domains match, 2=only if hosts match ***/
user_pref("network.http.referer.XOriginPolicy", 1);
/* 1604: CROSS ORIGIN: control the amount of information to send (FF52+)
 * 0=send full URI (default), 1=scheme+host+path+port, 2=scheme+host+port ***/
user_pref("network.http.referer.XOriginTrimmingPolicy", 0);
/* 1605: ALL: disable spoofing a referer
 * [WARNING] Spoofing effectively disables the anti-CSRF (Cross-Site Request Forgery) protections that some sites may rely on ***/
user_pref("network.http.referer.spoofSource", false);
/* 1606: ALL: set the default Referrer Policy
 * 0=no-referer, 1=same-origin, 2=strict-origin-when-cross-origin, 3=no-referrer-when-downgrade
 * [NOTE] This is only a default, it can be overridden by a site-controlled Referrer Policy
 * [1] https://www.w3.org/TR/referrer-policy/
 * [2] https://developer.mozilla.org/docs/Web/HTTP/Headers/Referrer-Policy
 * [3] https://blog.mozilla.org/security/2018/01/31/preventing-data-leaks-by-stripping-path-information-in-http-referrers/ ***/
user_pref("network.http.referer.userControlPolicy", 3); // (FF53-FF58) default: 3
user_pref("network.http.referer.defaultPolicy", 3); // (FF59+) default: 3
user_pref("network.http.referer.defaultPolicy.pbmode", 2); // (FF59+) default: 2
/* 1607: TOR: hide (not spoof) referrer when leaving a .onion domain (FF54+)
 * [NOTE] Firefox cannot access .onion sites by default. We recommend you use
 * TBB (Tor Browser Bundle) which is specifically designed for the dark web
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1305144 ***/
user_pref("network.http.referer.hideOnionSource", true);
/* 1610: ALL: disable the DNT HTTP header, which is essentially USELESS
 * It is voluntary and most ad networks do not honor it. DNT is *NOT* how you stop being data mined.
 * Don't encourage a setting that gives any legitimacy to 3rd parties being in control of your privacy.
 * Sending a DNT header *highly likely* raises entropy, especially in standard windows.
 * [SETTING-56+] Options>Privacy & Security>Tracking Protecting>Send websites a "Do Not Track"...
 * [SETTING-ESR] Options>Privacy>Use Tracking Protecting>manage your Do Not Track settings
 * [NOTE] DNT is enforced with TP (see 0420) regardless of this pref (e.g. in default PB Mode)
 * [NOTE] If you use NoScript MAKE SURE to set the pref noscript.doNotTrack.enabled to match ***/
user_pref("privacy.donottrackheader.enabled", false);

/*** 1700: CONTAINERS [SETUP]
     [1] https://support.mozilla.org/kb/containers-experiment
     [2] https://wiki.mozilla.org/Security/Contextual_Identity_Project/Containers
     [3] https://github.com/mozilla/testpilot-containers
***/
user_pref("_user.js.parrot", "1700 syntax error: the parrot's bit the dust!");
/* 1701: enable Container Tabs setting in preferences (see 1702) (FF50+)
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1279029 ***/
   // user_pref("privacy.userContext.ui.enabled", true);
/* 1702: enable Container Tabs (FF50+)
 * [SETTING-56+] Options>Privacy & Security>Tabs>Enable Container Tabs
 * [SETTING-ESR] Options>Privacy>Container Tabs>Enable Container Tabs ***/
   // user_pref("privacy.userContext.enabled", true);
/* 1703: enable a private container for thumbnail loads (FF51+) ***/
   // user_pref("privacy.usercontext.about_newtab_segregation.enabled", true);
/* 1704: set long press behaviour on "+ Tab" button to display container menu (FF53+)
 * 0=disables long press, 1=when clicked, the menu is shown
 * 2=the menu is shown after X milliseconds
 * [NOTE] The menu does not contain a non-container tab option
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1328756 ***/
   // user_pref("privacy.userContext.longPressBehavior", 2);

/*** 1800: PLUGINS ***/
user_pref("_user.js.parrot", "1800 syntax error: the parrot's pushing up daisies!");
/* 1801: set default plugin state (i.e. new plugins on discovery) to never activate
 * 0=disabled, 1=ask to activate, 2=active - you can override individual plugins ***/
user_pref("plugin.default.state", 0);
user_pref("plugin.defaultXpi.state", 0);
/* 1802: enable click to play and set to 0 minutes ***/
user_pref("plugins.click_to_play", true);
user_pref("plugin.sessionPermissionNow.intervalInMinutes", 0);
/* 1803: set a plugin state: 0=deactivated 1=ask 2=enabled (Flash example)
 * you can set all these plugin.state's via Add-ons>Plugins or search for plugin.state in about:config
 * [NOTE] You can still over-ride individual sites e.g. youtube via site permissions
 * [1] https://www.ghacks.net/2013/07/09/how-to-make-sure-that-a-firefox-plugin-never-activates-again/ ***/
   // user_pref("plugin.state.flash", 0);
/* 1804: disable plugins using external/untrusted scripts with XPCOM or XPConnect ***/
user_pref("security.xpconnect.plugin.unrestricted", false);
/* 1805: disable scanning for plugins [WINDOWS]
 * [1] http://kb.mozillazine.org/Plugin_scanning
 * plid.all = whether to scan the directories specified in the Windows registry for PLIDs.
 * Used to detect RealPlayer, Java, Antivirus etc, but since FF52 only covers Flash ***/
user_pref("plugin.scan.plid.all", false);
/* 1820: disable all GMP (Gecko Media Plugins) [SETUP]
 * [1] https://wiki.mozilla.org/GeckoMediaPlugins ***/
user_pref("media.gmp-provider.enabled", false);
user_pref("media.gmp.trial-create.enabled", false);
user_pref("media.gmp-manager.url", "data:text/plain,");
user_pref("media.gmp-manager.url.override", "data:text/plain,"); // (hidden pref)
user_pref("media.gmp-manager.updateEnabled", false); // disable local fallback (hidden pref)
/* 1825: disable widevine CDM (Content Decryption Module) [SETUP] ***/
user_pref("media.gmp-widevinecdm.visible", false);
user_pref("media.gmp-widevinecdm.enabled", false);
user_pref("media.gmp-widevinecdm.autoupdate", false);
/* 1830: disable all DRM content (EME: Encryption Media Extension) [SETUP]
 * [1] https://www.eff.org/deeplinks/2017/10/drms-dead-canary-how-we-just-lost-web-what-we-learned-it-and-what-we-need-do-next ***/
user_pref("media.eme.enabled", false); // Options>Content>Play DRM Content
user_pref("browser.eme.ui.enabled", false); // hides "Play DRM Content" checkbox [RESTART]
/* 1840: disable the OpenH264 Video Codec by Cisco to "Never Activate"
 * This is the bundled codec used for video chat in WebRTC ***/
user_pref("media.gmp-gmpopenh264.enabled", false); // (hidden pref)
user_pref("media.gmp-gmpopenh264.autoupdate", false);

/*** 2000: MEDIA / CAMERA / MIC ***/
user_pref("_user.js.parrot", "2000 syntax error: the parrot's snuffed it!");
/* 2001: disable WebRTC (Web Real-Time Communication)
 * [1] https://www.privacytools.io/#webrtc ***/
user_pref("media.peerconnection.enabled", false);
user_pref("media.peerconnection.use_document_iceservers", false);
user_pref("media.peerconnection.video.enabled", false);
user_pref("media.peerconnection.identity.enabled", false);
user_pref("media.peerconnection.identity.timeout", 1);
user_pref("media.peerconnection.turn.disable", true);
user_pref("media.peerconnection.ice.tcp", false);
user_pref("media.navigator.video.enabled", false); // video capability for WebRTC
/* 2002: limit WebRTC IP leaks if using WebRTC
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1189041
 * [2] https://bugzilla.mozilla.org/show_bug.cgi?id=1297416
 * [3] https://wiki.mozilla.org/Media/WebRTC/Privacy ***/
user_pref("media.peerconnection.ice.default_address_only", true); // (FF42-FF50)
user_pref("media.peerconnection.ice.no_host", true); // (FF51+)
/* 2010: disable WebGL (Web Graphics Library), force bare minimum feature set if used & disable WebGL extensions
 * [1] https://www.contextis.com/resources/blog/webgl-new-dimension-browser-exploitation/
 * [2] https://security.stackexchange.com/questions/13799/is-webgl-a-security-concern ***/
user_pref("webgl.disabled", true);
user_pref("pdfjs.enableWebGL", false);
user_pref("webgl.min_capability_mode", true);
user_pref("webgl.disable-extensions", true);
user_pref("webgl.disable-fail-if-major-performance-caveat", true);
/* 2011: disable WebGL debug info being available to websites
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1171228
 * [2] https://developer.mozilla.org/docs/Web/API/WEBGL_debug_renderer_info ***/
user_pref("webgl.enable-debug-renderer-info", false);
/* 2012: disable two more webgl preferences (FF51+) ***/
user_pref("webgl.dxgl.enabled", false); // [WINDOWS]
user_pref("webgl.enable-webgl2", false);
/* 2022: disable screensharing ***/
user_pref("media.getusermedia.screensharing.enabled", false);
user_pref("media.getusermedia.screensharing.allowed_domains", "");
user_pref("media.getusermedia.browser.enabled", false);
user_pref("media.getusermedia.audiocapture.enabled", false);
/* 2023: disable camera stuff ***/
user_pref("camera.control.face_detection.enabled", false);
/* 2024: set a default permission for Camera/Microphone (FF58+)
 * 0=always ask (default), 1=allow, 2=block
 * [SETTING] to add site exceptions: Page Info>Permissions>Use the Camera/Microphone
 * [SETTING] to manage site exceptions: Options>Privacy>Permissions>Camera/Microphone>Settings ***/
   // user_pref("permissions.default.camera", 2);
   // user_pref("permissions.default.microphone", 2);
/* 2026: disable canvas capture stream
 * [1] https://developer.mozilla.org/docs/Web/API/HTMLCanvasElement/captureStream ***/
user_pref("canvas.capturestream.enabled", false);
/* 2027: disable camera image capture
 * [1] https://trac.torproject.org/projects/tor/ticket/16339 ***/
user_pref("dom.imagecapture.enabled", false);
/* 2028: disable offscreen canvas
 * [1] https://developer.mozilla.org/docs/Web/API/OffscreenCanvas ***/
user_pref("gfx.offscreencanvas.enabled", false);
/* 2030: disable auto-play of HTML5 media
 * [WARNING] This may break video playback on various sites ***/
user_pref("media.autoplay.enabled", false);
/* 2031: disable audio auto-play in non-active tabs (FF51+)
 * [1] https://www.ghacks.net/2016/11/14/firefox-51-blocks-automatic-audio-playback-in-non-active-tabs/ ***/
user_pref("media.block-autoplay-until-in-foreground", true);

/*** 2200: UI MEDDLING
   see http://kb.mozillazine.org/Prevent_websites_from_disabling_new_window_features ***/
user_pref("_user.js.parrot", "2200 syntax error: the parrot's 'istory!");
/* 2201: disable website control over browser right-click context menu
 * [NOTE] Shift-Right-Click will always bring up the browser right-click context menu ***/
   // user_pref("dom.event.contextmenu.enabled", false);
/* 2202: disable [new window] scripts hiding or disabling the following ***/
user_pref("dom.disable_window_open_feature.location", true);
user_pref("dom.disable_window_open_feature.menubar", true);
user_pref("dom.disable_window_open_feature.resizable", true);
user_pref("dom.disable_window_open_feature.status", true);
user_pref("dom.disable_window_open_feature.toolbar", true);
/* 2203: disable [popup window] scripts hiding or disabling the following ***/
user_pref("dom.disable_window_flip", true); // window z-order
user_pref("dom.disable_window_move_resize", true);
user_pref("dom.disable_window_open_feature.close", true);
user_pref("dom.disable_window_open_feature.minimizable", true);
user_pref("dom.disable_window_open_feature.personalbar", true); // bookmarks toolbar
user_pref("dom.disable_window_open_feature.titlebar", true);
user_pref("dom.disable_window_status_change", true);
user_pref("dom.allow_scripts_to_close_windows", false);
/* 2204: disable links opening in a new window
 * This is to stop malicious window sizes and screen res leaks etc in conjunction
 * with 2203 dom.disable_window_move_resize=true | 2418 full-screen-api.enabled=false
 * [NOTE] You can still right click a link and select open in a new window
 * [TEST] https://people.torproject.org/~gk/misc/entire_desktop.html
 * [1] https://trac.torproject.org/projects/tor/ticket/9881 ***/
user_pref("browser.link.open_newwindow.restriction", 0);
/* 2205: disable "Confirm you want to leave" dialog on page close
 * Does not prevent JS leaks of the page close event.
 * [1] https://developer.mozilla.org/docs/Web/Events/beforeunload
 * [2] https://support.mozilla.org/questions/1043508 ***/
user_pref("dom.disable_beforeunload", true);

/*** 2300: WEB WORKERS [SETUP]
     A worker is a JS "background task" running in a global context, i.e. it is different from
     the current window. Workers can spawn new workers (must be the same origin & scheme),
     including service and shared workers. Shared workers can be utilized by multiple scripts and
     communicate between browsing contexts (windows/tabs/iframes) and can even control your cache.

     [WARNING] Disabling workers *will* break sites (e.g. Google Street View, Twitter).
     [UPDATE] uMatrix 1.2.0+ allows a per-scope control for workers (2301) and service workers (2302)
              #Required reading [#] https://github.com/gorhill/uMatrix/releases/tag/1.2.0

     [1]    Web Workers: https://developer.mozilla.org/docs/Web/API/Web_Workers_API
     [2]         Worker: https://developer.mozilla.org/docs/Web/API/Worker
     [3] Service Worker: https://developer.mozilla.org/docs/Web/API/Service_Worker_API
     [4]   SharedWorker: https://developer.mozilla.org/docs/Web/API/SharedWorker
     [5]   ChromeWorker: https://developer.mozilla.org/docs/Web/API/ChromeWorker
     [6]  Notifications: https://support.mozilla.org/questions/1165867#answer-981820
 ***/
user_pref("_user.js.parrot", "2300 syntax error: the parrot's off the twig!");
/* 2301: disable workers
 * [NOTE] CVE-2016-5259, CVE-2016-2812, CVE-2016-1949, CVE-2016-5287 (fixed) ***/
user_pref("dom.workers.enabled", false);
/* 2302: disable service workers
 * Service workers essentially act as proxy servers that sit between web apps, and the browser
 * and network, are event driven, and can control the web page/site it is associated with,
 * intercepting and modifying navigation and resource requests, and caching resources.
 * [NOTE] Service worker APIs are hidden (in Firefox) and cannot be used when in PB mode.
 * [NOTE] Service workers only run over HTTPS. Service Workers have no DOM access. ***/
user_pref("dom.serviceWorkers.enabled", false);
/* 2304: disable web notifications
 * [1] https://developer.mozilla.org/docs/Web/API/Notifications_API ***/
user_pref("dom.webnotifications.enabled", false); // (FF22+)
user_pref("dom.webnotifications.serviceworker.enabled", false); // (FF44+)
/* 2305: set a default permission for Notifications (see 2304) (FF58+)
 * [SETTING] to add site exceptions: Page Info>Permissions>Receive Notifications
 * [SETTING] to manage site exceptions: Options>Privacy>Permissions>Notifications>Settings ***/
   // user_pref("permissions.default.desktop-notification", 2); // 0=always ask (default), 1=allow, 2=block
/* 2306: disable push notifications (FF44+)
 * web apps can receive messages pushed to them from a server, whether or
 * not the web app is in the foreground, or even currently loaded
 * [1] https://developer.mozilla.org/docs/Web/API/Push_API ***/
user_pref("dom.push.enabled", false);
user_pref("dom.push.connection.enabled", false);
user_pref("dom.push.serverURL", "");
user_pref("dom.push.userAgentID", "");

/*** 2400: DOM (DOCUMENT OBJECT MODEL) & JAVASCRIPT ***/
user_pref("_user.js.parrot", "2400 syntax error: the parrot's kicked the bucket!");
/* 2402: disable website access to clipboard events/content
 * [WARNING] This will break some sites functionality such as pasting into facebook, wordpress
 * this applies to onCut, onCopy, onPaste events - i.e. you have to interact with
 * the website for it to look at the clipboard
 * [1] https://www.ghacks.net/2014/01/08/block-websites-reading-modifying-clipboard-contents-firefox/ ***/
user_pref("dom.event.clipboardevents.enabled", false);
/* 2403: disable clipboard commands (cut/copy) from "non-privileged" content (FF41+)
 * this disables document.execCommand("cut"/"copy") to protect your clipboard
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1170911 ***/
user_pref("dom.allow_cut_copy", false); // (hidden pref)
/* 2414: disable shaking the screen ***/
user_pref("dom.vibrator.enabled", false);
/* 2415: set max popups from a single non-click event - default is 20! ***/
user_pref("dom.popup_maximum", 3);
/* 2415b: limit events that can cause a popup
 * default is "change click dblclick mouseup pointerup notificationclick reset submit touchend"
 * [1] http://kb.mozillazine.org/Dom.popup_allowed_events ***/
user_pref("dom.popup_allowed_events", "click dblclick");
/* 2416: disable idle observation ***/
user_pref("dom.idle-observers-api.enabled", false);
/* 2418: disable full-screen API
 * false=block, true=ask ***/
user_pref("full-screen-api.enabled", false);
/* 2420: disable asm.js (FF22+)
 * [1] http://asmjs.org/
 * [2] https://www.mozilla.org/security/advisories/mfsa2015-29/
 * [3] https://www.mozilla.org/security/advisories/mfsa2015-50/
 * [4] https://www.mozilla.org/security/advisories/mfsa2017-01/#CVE-2017-5375
 * [5] https://www.mozilla.org/security/advisories/mfsa2017-05/#CVE-2017-5400
 * [6] https://rh0dev.github.io/blog/2017/the-return-of-the-jit/ ***/
user_pref("javascript.options.asmjs", false);
/* 2421: disable Ion and baseline JIT to help harden JS against exploits
 * [WARNING] Causes the odd site issue and there is also a performance loss
 * [1] https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2015-0817 ***/
   // user_pref("javascript.options.ion", false);
   // user_pref("javascript.options.baselinejit", false);
/* 2422: disable WebAssembly for now (FF52+)
 * [1] https://developer.mozilla.org/docs/WebAssembly ***/
user_pref("javascript.options.wasm", false);
/* 2426: disable Intersection Observer API (FF53+)
 * Almost a year to complete, three versions late to stable (as default false),
 * number #1 cause of crashes in nightly numerous times, and is (primarily) an
 * ad network API for "ad viewability checks" down to a pixel level
 * [1] https://developer.mozilla.org/docs/Web/API/Intersection_Observer_API
 * [2] https://w3c.github.io/IntersectionObserver/
 * [3] https://bugzilla.mozilla.org/show_bug.cgi?id=1243846 ***/
user_pref("dom.IntersectionObserver.enabled", false);
/* 2427: disable Shared Memory (Spectre mitigation)
 * [1] https://github.com/tc39/ecmascript_sharedmem/blob/master/TUTORIAL.md
 * [2] https://blog.mozilla.org/security/2018/01/03/mitigations-landing-new-class-timing-attack/ ***/
user_pref("javascript.options.shared_memory", false);

/*** 2500: HARDWARE FINGERPRINTING ***/
user_pref("_user.js.parrot", "2500 syntax error: the parrot's shuffled off 'is mortal coil!");
/* 2504: disable virtual reality devices
 * [WARNING] [SETUP] Optional protection depending on your connected devices
 * [1] https://developer.mozilla.org/docs/Web/API/WebVR_API ***/
   // user_pref("dom.vr.enabled", false);
/* 2505: disable media device enumeration (FF29+)
 * [NOTE] media.peerconnection.enabled should also be set to false (see 2001)
 * [1] https://wiki.mozilla.org/Media/getUserMedia
 * [2] https://developer.mozilla.org/docs/Web/API/MediaDevices/enumerateDevices ***/
user_pref("media.navigator.enabled", false);
/* 2508: disable hardware acceleration to reduce graphics fingerprinting
 * [SETTING] Options>General>Performance>Custom>Use hardware acceleration when available
 * [WARNING] [SETUP] Affects text rendering (fonts will look different), impacts video performance,
 * and parts of Quantum that utilize the GPU will also be affected as they are rolled out
 * [1] https://wiki.mozilla.org/Platform/GFX/HardwareAcceleration ***/
   // user_pref("gfx.direct2d.disabled", true); // [WINDOWS]
user_pref("layers.acceleration.disabled", true);
/* 2510: disable Web Audio API (FF51+)
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1288359 ***/
user_pref("dom.webaudio.enabled", false);
/* 2511: disable MediaDevices change detection (FF51+) (enabled by default starting FF52+)
 * [1] https://developer.mozilla.org/docs/Web/Events/devicechange
 * [2] https://developer.mozilla.org/docs/Web/API/MediaDevices/ondevicechange ***/
user_pref("media.ondevicechange.enabled", false);

/*** 2600: MISC - LEAKS / FINGERPRINTING / PRIVACY / SECURITY ***/
user_pref("_user.js.parrot", "2600 syntax error: the parrot's run down the curtain!");
/* 2601: disable sending additional analytics to web servers
 * [1] https://developer.mozilla.org/docs/Web/API/Navigator/sendBeacon ***/
user_pref("beacon.enabled", false);
/* 2602: discourage downloading to desktop (0=desktop 1=downloads 2=last used)
 * [NOTE] To set your default "downloads": Options>General>Downloads>Save files to ***/
user_pref("browser.download.folderList", 2);
/* 2603: enforce user interaction for security by always asking the user where to download ***/
user_pref("browser.download.useDownloadDir", false);
/* 2604: remove temp files opened with an external application
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=302433 ***/
user_pref("browser.helperApps.deleteTempFileOnExit", true);
/* 2605: disable adding downloads to the system's "recent documents" list ***/
user_pref("browser.download.manager.addToRecentDocs", false);
/* 2606: disable hiding mime types (Options>Applications) not associated with a plugin ***/
user_pref("browser.download.hide_plugins_without_extensions", false);
/* 2607: disable page thumbnail collection
 * look in profile/thumbnails directory - you may want to clean that out ***/
user_pref("browser.pagethumbnails.capturing_disabled", true); // (hidden pref)
/* 2608: disable JAR from opening Unsafe File Types ***/
user_pref("network.jar.open-unsafe-types", false);
/* 2609: disable exposure of system colors to CSS or canvas (FF44+)
 * [NOTE] see [2] bug may cause black on black for elements with undefined colors
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=232227
 * [2] https://bugzilla.mozilla.org/show_bug.cgi?id=1330876 ***/
user_pref("ui.use_standins_for_native_colors", true); // (hidden pref)
/* 2610: remove special permissions for certain mozilla domains (FF35+)
 * [1] resource://app/defaults/permissions ***/
user_pref("permissions.manager.defaultsUrl", "");
/* 2611: disable WebIDE to prevent remote debugging and extension downloads
 * [1] https://trac.torproject.org/projects/tor/ticket/16222 ***/
user_pref("devtools.webide.autoinstallADBHelper", false);
user_pref("devtools.debugger.remote-enabled", false);
user_pref("devtools.webide.enabled", false);
/* 2614: disable HTTP2 (which was based on SPDY which is now deprecated)
 * HTTP2 raises concerns with "multiplexing" and "server push", does nothing to enhance
 * privacy, and in fact opens up a number of server-side fingerprinting opportunities
 * [1] https://http2.github.io/faq/
 * [2] http://blog.scottlogic.com/2014/11/07/http-2-a-quick-look.html
 * [3] https://queue.acm.org/detail.cfm?id=2716278
 * [4] https://github.com/ghacksuserjs/ghacks-user.js/issues/107 ***/
user_pref("network.http.spdy.enabled", false);
user_pref("network.http.spdy.enabled.deps", false);
user_pref("network.http.spdy.enabled.http2", false);
/* 2617: enable Firefox's built-in PDF reader [SETUP]
 * [SETTING-56+] Options>General>Applications>Portable Document Format (PDF)
 * [SETTING-ESR] Options>Applications>Portable Document Format (PDF)
 * This setting controls if the option "Display in Firefox" in the above setting is available
 * and by effect controls whether PDFs are handled in-browser or externally ("Ask" or "Open With")
 *   [WHY USE false=default=view PDFs in Firefox]
 * pdfjs is lightweight, open source and as secure as any pdf reader out there, certainly better and more
 * vetted than most. Exploits are rare (1 serious case in 3 years), treated seriously and patched quickly.
 * It doesn't break "state separation" of browser content (by not sharing with OS, independent apps). It
 * maintains disk avoidance and application data isolation. It's convenient. You can still save to disk.
 *   [WHY USE true=open with or save to disk]
 * If you think a particular external app is more secure...
 *   [NOTE]
 * See 2662, and JS can still force a pdf to open in-browser by bundling its own code (rare) ***/
user_pref("pdfjs.disabled", false);
/* 2618: enforce the proxy server to do any DNS lookups when using SOCKS
 * e.g. in TOR, this stops your local DNS server from knowing your Tor destination
 * as a remote Tor node will handle the DNS request
 * [1] http://kb.mozillazine.org/Network.proxy.socks_remote_dns
 * [2] https://trac.torproject.org/projects/tor/wiki/doc/TorifyHOWTO/WebBrowsers ***/
user_pref("network.proxy.socks_remote_dns", true);
/* 2619: limit HTTP redirects (this does not control redirects with HTML meta tags or JS)
 * [WARNING] A low setting of 5 or under will probably break some sites (e.g. gmail logins)
 * To control HTML Meta tag and JS redirects, use an extension. Default is 20 ***/
user_pref("network.http.redirection-limit", 10);
/* 2620: disable middle mouse click opening links from clipboard
 * [1] https://trac.torproject.org/projects/tor/ticket/10089
 * [2] http://kb.mozillazine.org/Middlemouse.contentLoadURL ***/
user_pref("middlemouse.contentLoadURL", false);
/* 2621: disable IPv6 (included for knowledge ONLY [WARNING] do not do this)
 * This is all about covert channels such as MAC addresses being included/abused in the
 * IPv6 protocol for tracking. If you want to mask your IP address, this is not the way
 * to do it. It's 2016, IPv6 is here. Here are some old links
 * 2010: https://christopher-parsons.com/ipv6-and-the-future-of-privacy/
 * 2011: https://iapp.org/news/a/2011-09-09-facing-the-privacy-implications-of-ipv6/
 * 2012: http://www.zdnet.com/article/security-versus-privacy-with-ipv6-deployment/
 * [NOTE] It is a myth that disabling IPv6 will speed up your internet connection
 * [1] https://www.howtogeek.com/195062/no-disabling-ipv6-probably-wont-speed-up-your-internet-connection/ ***/
   // user_pref("network.dns.disableIPv6", true);
   // user_pref("network.http.fast-fallback-to-IPv4", true);
/* 2622: enforce a security delay when installing extensions (milliseconds)
 * default=1000, This also covers the delay in "Save" on downloading files.
 * [1] http://kb.mozillazine.org/Disable_extension_install_delay_-_Firefox
 * [2] https://www.squarefree.com/2004/07/01/race-conditions-in-security-dialogs/ ***/
user_pref("security.dialog_enable_delay", 700);
/* 2623: enable Strict File Origin Policy on local files
 * [1] http://kb.mozillazine.org/Security.fileuri.strict_origin_policy ***/
user_pref("security.fileuri.strict_origin_policy", true);
/* 2624: enable Subresource Integrity (SRI) (FF43+)
 * [1] https://developer.mozilla.org/docs/Web/Security/Subresource_Integrity
 * [2] https://wiki.mozilla.org/Security/Subresource_Integrity ***/
user_pref("security.sri.enable", true); // default: true
/* 2625: disable DNS requests for hostnames with a .onion TLD (FF45+)
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1228457 ***/
user_pref("network.dns.blockDotOnion", true);
/* 2626: disable optional user agent token
 * [1] https://developer.mozilla.org/docs/Web/HTTP/Headers/User-Agent/Firefox ***/
user_pref("general.useragent.compatMode.firefox", false); // default: false
/* 2628: disable UITour backend so there is no chance that a remote page can use it ***/
user_pref("browser.uitour.enabled", false);
user_pref("browser.uitour.url", "");
/* 2629: disable remote JAR files being opened, regardless of content type (FF42+)
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1173171 ***/
user_pref("network.jar.block-remote-files", true);
/* 2630: prevent accessibility services from accessing your browser [RESTART]
 * [SETTING] Options>Privacy & Security>Permissions>Prevent accessibility services from accessing your browser
 * [1] https://support.mozilla.org/kb/accessibility-services ***/
user_pref("accessibility.force_disabled", 1);
/* 2631: block web content in file processes (FF55+)
 * [WARNING] [SETUP] You may want to disable this for corporate or developer environments
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1343184 ***/
user_pref("browser.tabs.remote.allowLinkedWebInFileUriProcess", false);
/* 2632: disable websites overriding Firefox's keyboard shortcuts (FF58+)
 * [SETTING] to add site exceptions: Page Info>Permissions>Override Keyboard Shortcuts
 * [NOTE] At the time of writing, causes issues with delete and backspace keys ***/
   // user_pref("permissions.default.shortcuts", 2); //  0 (default) or 1=allow, 2=block
/* 2662: disable "open with" in download dialog (FF50+)
 * This is very useful to enable when the browser is sandboxed (e.g. via AppArmor)
 * in such a way that it is forbidden to run external applications.
 * [SETUP] This may interfere with some users' workflow or methods
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1281959 ***/
user_pref("browser.download.forbid_open_with", true);
/* 2663: disable MathML (Mathematical Markup Language) (FF51+)
 * [TEST] http://browserspy.dk/mathml.php
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1173199 ***/
user_pref("mathml.disabled", true);
/* 2664: disable DeviceStorage API
 * [1] https://wiki.mozilla.org/WebAPI/DeviceStorageAPI ***/
user_pref("device.storage.enabled", false);
/* 2665: remove webchannel whitelist ***/
user_pref("webchannel.allowObject.urlWhitelist", "");
/* 2666: disable HTTP Alternative Services
 * [1] https://www.ghacks.net/2015/08/18/a-comprehensive-list-of-firefox-privacy-and-security-settings/#comment-3970881 ***/
user_pref("network.http.altsvc.enabled", false);
user_pref("network.http.altsvc.oe", false);
/* 2667: disable various developer tools in browser context
 * [SETTING] Devtools>Advanced Settings>Enable browser chrome and add-on debugging toolboxes
 * [1] https://github.com/pyllyukko/user.js/issues/179#issuecomment-246468676 ***/
user_pref("devtools.chrome.enabled", false);
/* 2668: lock down allowed extension directories
 * [WARNING] This will break extensions that do not use the default XPI directories
 * [1] https://mike.kaply.com/2012/02/21/understanding-add-on-scopes/
 * [1] archived: https://archive.is/DYjAM ***/
user_pref("extensions.enabledScopes", 1); // (hidden pref)
user_pref("extensions.autoDisableScopes", 15);
/* 2669: remove paths when sending URLs to PAC scripts (FF51+)
 * CVE-2017-5384: Information disclosure via Proxy Auto-Config (PAC)
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1255474 ***/
user_pref("network.proxy.autoconfig_url.include_path", false);
/* 2670: disable "image/" mime types bypassing CSP (FF51+)
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1288361 ***/
user_pref("security.block_script_with_wrong_mime", true);
/* 2671: disable in-content SVG (Scalable Vector Graphics) (FF53+)
 * [WARNING] SVG is fairly common (~15% of the top 10K sites), so will cause some breakage
 * including youtube player controls. Best left for "hardened" or specific profiles.
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1216893 ***/
   // user_pref("svg.disabled", true);
/* 2672: enforce Punycode for Internationalized Domain Names to eliminate possible spoofing security risk
 * Firefox has *some* protections to mitigate the risk, but it is better to be safe
 * than sorry. The downside: it will also display legitimate IDN's punycoded, which
 * might be undesirable for users from countries with non-latin alphabets
 * [TEST] https://www.xn--80ak6aa92e.com/ (www.apple.com)
 * [1] http://kb.mozillazine.org/Network.IDN_show_punycode
 * [2] https://wiki.mozilla.org/IDN_Display_Algorithm
 * [3] https://en.wikipedia.org/wiki/IDN_homograph_attack
 * [4] CVE-2017-5383: https://www.mozilla.org/security/advisories/mfsa2017-02/
 * [5] https://www.xudongz.com/blog/2017/idn-phishing/ ***/
user_pref("network.IDN_show_punycode", true);
/* 2673: enable CSP (Content Security Policy)
 * [1] https://developer.mozilla.org/docs/Web/HTTP/CSP ***/
user_pref("security.csp.enable", true); // default: true
/* 2674: enable CSP 1.1 experimental hash-source directive (FF29+)
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=855326
 * [2] https://bugzilla.mozilla.org/show_bug.cgi?id=883975 ***/
user_pref("security.csp.experimentalEnabled", true);
/* 2675: block top level window data: URIs (FF56+)
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1331351
 * [2] https://www.wordfence.com/blog/2017/01/gmail-phishing-data-uri/
 * [3] https://www.fxsitecompat.com/en-CA/docs/2017/data-url-navigations-on-top-level-window-will-be-blocked/ ***/
user_pref("security.data_uri.block_toplevel_data_uri_navigations", true);

/*** 2700: PERSISTENT STORAGE
     Data SET by websites including
            cookies : profile\cookies.sqlite
       localStorage : profile\webappsstore.sqlite
          indexedDB : profile\storage\default
           appCache : profile\OfflineCache
     serviceWorkers :
***/
user_pref("_user.js.parrot", "2700 syntax error: the parrot's joined the bleedin' choir invisible!");
/* 2701: disable cookies on all sites [SETUP]
 * You can set exceptions under site permissions or use an extension
 * 0=allow all 1=allow same host 2=disallow all 3=allow 3rd party if it already set a cookie
 * [SETTING-56+] Options>Privacy & Security>History>Custom Settings>Accept cookies from sites
 * [SETTING-ESR] Options>Privacy>History>Custom Settings>Accept cookies from sites
 * [NOTE] This also controls access to 3rd party Web Storage, IndexedDB, Cache API and Service Worker Cache
 * [1] https://www.fxsitecompat.com/en-CA/docs/2015/web-storage-indexeddb-cache-api-now-obey-third-party-cookies-preference/ ***/
user_pref("network.cookie.cookieBehavior", 2);
/* 2702: set third-party cookies (i.e ALL) (if enabled, see above pref) to session-only
   and (FF58+) set third-party non-secure (i.e HTTP) cookies to session-only
   [NOTE] .sessionOnly overrides .nonsecureSessionOnly except when .sessionOnly=false and
   .nonsecureSessionOnly=true. This allows you to keep HTTPS cookies, but session-only HTTP ones
 * [1] https://feeding.cloud.geek.nz/posts/tweaking-cookies-for-privacy-in-firefox/
 * [2] http://kb.mozillazine.org/Network.cookie.thirdparty.sessionOnly ***/
user_pref("network.cookie.thirdparty.sessionOnly", true);
user_pref("network.cookie.thirdparty.nonsecureSessionOnly", true); // (FF58+)
/* 2703: set cookie lifetime policy
 * 0=until they expire (default), 2=until you close Firefox, 3=for n days (see next pref)
 * [SETTING-56+] Options>Privacy & Security>History>Custom Settings>Accept cookies from sites>Keep until
 * [SETTING-ESR] Options>Privacy>History>Custom Settings>Accept cookies from sites>Keep until ***/
   // user_pref("network.cookie.lifetimePolicy", 0);
/* 2704: set cookie lifetime in days (see above pref) - default is 90 days ***/
   // user_pref("network.cookie.lifetime.days", 90);
/* 2705: disable HTTP sites setting cookies with the "secure" directive (FF52+)
 * [1] https://developer.mozilla.org/Firefox/Releases/52#HTTP ***/
user_pref("network.cookie.leave-secure-alone", true); // default: true
/* 2710: disable DOM (Document Object Model) Storage
 * [WARNING] This will break a LOT of sites' functionality.
 * You are better off using an extension for more granular control ***/
   // user_pref("dom.storage.enabled", false);
/* 2711: clear localStorage and UUID when an extension is uninstalled
 * [NOTE] Both preferences must be the same
 * [1] https://developer.mozilla.org/Add-ons/WebExtensions/API/storage/local
 * [2] https://bugzilla.mozilla.org/show_bug.cgi?id=1213990 ***/
user_pref("extensions.webextensions.keepStorageOnUninstall", false);
user_pref("extensions.webextensions.keepUuidOnUninstall", false);
/* 2720: disable JS storing data permanently [SETUP]
 * [WARNING] This BREAKS uBlock Origin [1.14.0+] and other extensions that require IndexedDB
 * [1] https://github.com/gorhill/uBlock/releases/tag/1.14.0
 * [WARNING] This *will* break other extensions including legacy, and *will* break some sites ***/
   // user_pref("dom.indexedDB.enabled", false);
/* 2730: disable offline cache ***/
user_pref("browser.cache.offline.enable", false);
/* 2731: enforce websites to ask to store data for offline use
 * [1] https://support.mozilla.org/questions/1098540
 * [2] https://bugzilla.mozilla.org/show_bug.cgi?id=959985 ***/
user_pref("offline-apps.allow_by_default", false);
/* 2732: display a notification when websites ask to store data for offline use
 * [SETTING-56+] Options>Privacy & Security>Offline Web Content and User Data>Tell you when a website asks...
 * [SETTING-ESR] Options>Advanced>Network>Tell me when a website asks to store data for offline use ***/
user_pref("browser.offline-apps.notify", true);
/* 2733: set size of warning quota for offline cache (default 51200)
 * Offline cache is only used in rare cases to store data locally. FF will store small amounts
 * (default <50MB) of data in the offline (application) cache without asking for permission. ***/
   // user_pref("offline-apps.quota.warn", 51200);
/* 2740: disable service workers cache and cache storage
 * [1] https://w3c.github.io/ServiceWorker/#privacy ***/
user_pref("dom.caches.enabled", false);
/* 2750: disable Storage API
 * The API gives sites the ability to find out how much space they can use, how much
 * they are already using, and even control whether or not they need to be alerted
 * before the user agent disposes of site data in order to make room for other things.
 * [NOTE] This also controls the visibility of the "Options>Privacy & Security>Site Data"
 * section, which also requires Offline Cache (2730) enabled to function
 * [1] https://developer.mozilla.org/docs/Web/API/StorageManager
 * [2] https://developer.mozilla.org/docs/Web/API/Storage_API
 * [3] https://blog.mozilla.org/l10n/2017/03/07/firefox-l10n-report-aurora-54/ ***/
user_pref("dom.storageManager.enabled", false); // (FF51+)
user_pref("browser.storageManager.enabled", false); // (FF53+)

/*** 2800: SHUTDOWN [SETUP]
     You should set the values to what suits you best. Be aware that the settings below clear
     browsing, download and form history, but not cookies (we expect you to use an extension).
     [NOTE] In both 2803 + 2804, the 'download' and 'history' prefs are combined in the
     Firefox interface as "Browsing & Download History" and their values will be synced
 ***/
user_pref("_user.js.parrot", "2800 syntax error: the parrot's bleedin' demised!");
/* 2802: enable Firefox to clear history items on shutdown
 * [SETTING-56+] Options>Privacy & Security>History>Clear history when Firefox closes
 * [SETTING-ESR] Options>Privacy>Clear history when Firefox closes ***/
user_pref("privacy.sanitize.sanitizeOnShutdown", true);
/* 2803: set what history items to clear on shutdown
 * [SETTING-56+] Options>Privacy & Security>History>Clear history when Firefox closes>Settings
 * [SETTING-ESR] Options>Privacy>Clear history when Firefox closes>Settings
 * [NOTE] If 'history' is true, downloads will also be cleared regardless of the value
 * but if 'history' is false, downloads can still be cleared independently
 * However, this may not always be the case. The interface combines and syncs these
 * prefs when set from there, and the sanitize code may change at any time ***/
user_pref("privacy.clearOnShutdown.cache", true);
user_pref("privacy.clearOnShutdown.cookies", false);
user_pref("privacy.clearOnShutdown.downloads", true); // see note above
user_pref("privacy.clearOnShutdown.formdata", true); // Form & Search History
user_pref("privacy.clearOnShutdown.history", true); // Browsing & Download History
user_pref("privacy.clearOnShutdown.offlineApps", true); // Offline Website Data
user_pref("privacy.clearOnShutdown.sessions", true); // Active Logins
user_pref("privacy.clearOnShutdown.siteSettings", false); // Site Preferences
/* 2804: reset default history items to clear with Ctrl-Shift-Del (to match above)
 * This dialog can also be accessed from the menu History>Clear Recent History
 * Firefox remembers your last choices. This will reset them when you start Firefox.
 * [NOTE] Regardless of what you set privacy.cpd.downloads to, as soon as the dialog
 * for "Clear Recent History" is opened, it is synced to the same as 'history' ***/
user_pref("privacy.cpd.cache", true);
user_pref("privacy.cpd.cookies", false);
   // user_pref("privacy.cpd.downloads", true); // not used, see note above
user_pref("privacy.cpd.formdata", true); // Form & Search History
user_pref("privacy.cpd.history", true); // Browsing & Download History
user_pref("privacy.cpd.offlineApps", true); // Offline Website Data
user_pref("privacy.cpd.passwords", false); // this is not listed
user_pref("privacy.cpd.sessions", true); // Active Logins
user_pref("privacy.cpd.siteSettings", false); // Site Preferences
/* 2805: privacy.*.openWindows (clear session restore data) (FF34+)
 * [NOTE] There is a years-old bug that these cause two windows when Firefox restarts.
 * You do not need these anyway if session restore is disabled (see 1020) ***/
   // user_pref("privacy.clearOnShutdown.openWindows", true);
   // user_pref("privacy.cpd.openWindows", true);
/* 2806: reset default 'Time range to clear' for 'Clear Recent History' (see 2804)
 * Firefox remembers your last choice. This will reset the value when you start Firefox.
 * 0=everything, 1=last hour, 2=last two hours, 3=last four hours,
 * 4=today, 5=last five minutes, 6=last twenty-four hours
 * [NOTE] The values 5 + 6 are not listed in the dropdown, which will display a
 * blank value if they are used, but they do work as advertised ***/
user_pref("privacy.sanitize.timeSpan", 0);

/*** 4000: FIRST PARTY ISOLATION (FPI)
 ** 1277803 - isolate favicons (FF52+)
 ** 1264562 - isolate OCSP cache (FF52+)
 ** 1268726 - isolate Shared Workers (FF52+)
 ** 1316283 - isolate SSL session cache (FF52+)
 ** 1317927 - isolate media cache (FF53+)
 ** 1323644 - isolate HSTS and HPKP (FF54+)
 ** 1334690 - isolate HTTP Alternative Services (FF54+)
 ** 1334693 - isolate SPDY/HTTP2 (FF55+)
 ** 1337893 - isolate DNS cache (FF55+)
 ** 1344170 - isolate blob: URI (FF55+)
 ** 1300671 - isolate data:, about: URLs (FF55+)

 NOTE: FPI has some issues depending on your Firefox release
 ** 1418931 - [fixed in FF58+] IndexedDB (Offline Website Data) with FPI Origin Attributes
      are not removed with "Clear All/Recent History" or "On Close"
 ** 1381197 - [fixed in FF59+] extensions cannot control cookies with FPI Origin Attributes
***/
user_pref("_user.js.parrot", "4000 syntax error: the parrot's pegged out");
/* 4001: enable First Party Isolation (FF51+)
 * [WARNING] May break cross-domain logins and site functionality until perfected
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1260931 ***/
user_pref("privacy.firstparty.isolate", true);
/* 4002: enforce FPI restriction for window.opener (FF54+)
 * [NOTE] Setting this to false may reduce the breakage in 4001
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1319773#c22 ***/
user_pref("privacy.firstparty.isolate.restrict_opener_access", true);

/*** 4500: privacy.resistFingerprinting (RFP)
   This master switch will be used for a wide range of items, many of which will
   **override** existing prefs from FF55+, often providing a **better** solution

   IMPORTANT: As existing prefs become redundant, and some of them WILL interfere
   with how RFP works, they will be moved to section 4600 and made inactive

 ** 418986 - limit window.screen & CSS media queries leaking identifiable info (FF41+)
      [POC] http://ip-check.info/?lang=en (screen, usable screen, and browser window will match)
      [NOTE] Does not cover everything yet - https://bugzilla.mozilla.org/show_bug.cgi?id=1216800
      [NOTE] This will probably make your values pretty unique until you resize or snap the
      inner window width + height into standard/common resolutions (such as 1366x768)
      To set a size, open a XUL (chrome) page (such as about:config) which is at 100% zoom, hit
      Shift+F4 to open the scratchpad, type window.resizeTo(1366,768), hit Ctrl+R to run. Test
      your window size, do some math, resize to allow for all the non inner window elements
      [TEST] http://browserspy.dk/screen.php
 ** 1281949 - spoof screen orientation (FF50+)
 ** 1281963 - hide the contents of navigator.plugins and navigator.mimeTypes (FF50+)
 ** 1330890 - spoof timezone as UTC 0 (FF55+)
      FF58: Date.toLocaleFormat deprecated (818634)
      FF60: Date.toLocaleDateString and Intl.DateTimeFormat fixed (1409973)
 ** 1360039 - spoof navigator.hardwareConcurrency as 2 (see 4601) (FF55+)
      This spoof *shouldn't* affect core chrome/Firefox performance
 ** 1217238 - reduce precision of time exposed by javascript (FF55+)
 ** 1369303 - spoof/disable performance API (see 2410-deprecated, 4602, 4603) (FF56+)
 ** 1333651 & 1383495 & 1396468 & 1393283 & 1404608 - spoof Navigator API (see section 4700) (FF56+)
      FF56: The version number will be rounded down to the nearest multiple of 10
      FF57: The version number will match current ESR
      FF59: The OS will be reported as Windows, OSX, Android, or Linux (to reduce breakage)
 ** 1369319 - disable device sensor API (see 4604) (FF56+)
 ** 1369357 - disable site specific zoom (see 4605) (FF56+)
 ** 1337161 - hide gamepads from content (see 4606) (FF56+)
 ** 1372072 - spoof network information API as "unknown" (see 4607) (FF56+)
 ** 1333641 - reduce fingerprinting in WebSpeech API (see 4608) (FF56+)
 ** 1372069 & 1403813 - block geolocation requests (same as if you deny a site permission) (see 4609, 4612) (FF56+)
 ** 1369309 - spoof media statistics (see 4610) (FF57+)
 ** 1382499 - reduce screen co-ordinate fingerprinting in Touch API (see 4611) (FF57+)
 ** 1217290 - enable fingerprinting resistance for WebGL (see 2010-12) (FF57+)
 ** 1382545 - reduce fingerprinting in Animation API (FF57+)
 ** 1354633 - limit MediaError.message to a whitelist (FF57+)
 ** 1382533 - enable fingerprinting resistance for Presentation API (FF57+)
      This blocks exposure of local IP Addresses via mDNS (Multicast DNS)
 **  967895 - enable site permission prompt before allowing canvas data extraction (FF58+)
      FF59: Added to the site permissions panel (1413780)
      FF60: Only prompt for canvas data extraction when triggered by user input (1376865)
 ** 1372073 - spoof/block fingerprinting in MediaDevices API (FF59+)
 ** 1039069 - warn when language prefs are set to non en-US (see 0207, 0208) (FF59+)
 ** 1222285 - spoof keyboard events and suppress keyboard modifier events (FF59+)
      Spoofing mimics the content language of the document. Currently it only supports en-US.
      Modifier events suppressed are SHIFT, CTRL and both ALT keys. Chrome is not affected.
      FF60: Fixes keydown/keyup events (1438795)
***/
user_pref("_user.js.parrot", "4500 syntax error: the parrot's popped 'is clogs");
/* 4501: enable privacy.resistFingerprinting (FF41+)
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=418986 ***/
user_pref("privacy.resistFingerprinting", true); // (hidden pref) (not hidden FF55+)
/* 4502: set new window sizes to round to hundreds (FF55+) [SETUP]
 * [NOTE] Width will round down to multiples of 200s and height to 100s, to fit your screen.
 * The override values are a starting point to round from if you want some control
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1330882
 * [2] https://hardware.metrics.mozilla.com/ ***/
   // user_pref("privacy.window.maxInnerWidth", 1600); // (hidden pref)
   // user_pref("privacy.window.maxInnerHeight", 900); // (hidden pref)
/* 4503: disable mozAddonManager Web API (FF57+)
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1384330 ***/
   // user_pref("privacy.resistFingerprinting.block_mozAddonManager", true); // (hidden pref)

/*** 4600: RFP (4500) ALTERNATIVES [SETUP]
   * IF you DO use RFP (see 4500) then you DO NOT need these redundant prefs. In fact,
     some even cause RFP to not behave as you would expect and alter your fingerprint.
     Make sure they are RESET in about:config as per your Firefox version
   * IF you DO NOT use RFP or are on ESR... then turn on each ESR section below
***/
user_pref("_user.js.parrot", "4600 syntax error: the parrot's crossed the Jordan");
/* [NOTE] ESR52.x and non-RFP users replace the * with a slash on this line to enable these
// FF55+
// 4601: [2514] spoof (or limit?) number of CPU cores (FF48+)
   // [WARNING] *may* affect core chrome/Firefox performance, will affect content.
   // [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1008453
   // [2] https://trac.torproject.org/projects/tor/ticket/21675
   // [3] https://trac.torproject.org/projects/tor/ticket/22127
   // [4] https://html.spec.whatwg.org/multipage/workers.html#navigator.hardwareconcurrency
   // user_pref("dom.maxHardwareConcurrency", 2);
// * * * /
// FF56+
// 4602: [2411] disable resource/navigation timing
user_pref("dom.enable_resource_timing", false);
// 4603: [2412] disable timing attacks
   // [1] https://wiki.mozilla.org/Security/Reviews/Firefox/NavigationTimingAPI
user_pref("dom.enable_performance", false);
// 4604: [2512] disable device sensor API
   // [WARNING] [SETUP] Optional protection depending on your device
   // [1] https://trac.torproject.org/projects/tor/ticket/15758
   // [2] https://blog.lukaszolejnik.com/stealing-sensitive-browser-data-with-the-w3c-ambient-light-sensor-api/
   // [3] https://bugzilla.mozilla.org/show_bug.cgi?id=1357733
   // [4] https://bugzilla.mozilla.org/show_bug.cgi?id=1292751
   // user_pref("device.sensors.enabled", false);
// 4605: [2515] disable site specific zoom
   // Zoom levels affect screen res and are highly fingerprintable. This does not stop you using
   // zoom, it will just not use/remember any site specific settings. Zoom levels on new tabs
   // and new windows are reset to default and only the current tab retains the current zoom
user_pref("browser.zoom.siteSpecific", false);
// 4606: [2501] disable gamepad API - USB device ID enumeration
   // [WARNING] [SETUP] Optional protection depending on your connected devices
   // [1] https://trac.torproject.org/projects/tor/ticket/13023
   // user_pref("dom.gamepad.enabled", false);
// 4607: [2503] disable giving away network info (FF31+)
   // e.g. bluetooth, cellular, ethernet, wifi, wimax, other, mixed, unknown, none
   // [1] https://developer.mozilla.org/docs/Web/API/Network_Information_API
   // [2] https://wicg.github.io/netinfo/
   // [3] https://bugzilla.mozilla.org/show_bug.cgi?id=960426
user_pref("dom.netinfo.enabled", false);
// 4608: [2021] disable the SpeechSynthesis (Text-to-Speech) part of the Web Speech API
   // [1] https://developer.mozilla.org/docs/Web/API/Web_Speech_API
   // [2] https://developer.mozilla.org/docs/Web/API/SpeechSynthesis
   // [3] https://wiki.mozilla.org/HTML5_Speech_API
user_pref("media.webspeech.synth.enabled", false);
// 4609: [0201] disable Location-Aware Browsing
   // [1] https://www.mozilla.org/firefox/geolocation/
user_pref("geo.enabled", false);
// * * * /
// FF57+
// 4610: [2506] disable video statistics - JS performance fingerprinting (FF25+)
   // [1] https://trac.torproject.org/projects/tor/ticket/15757
   // [2] https://bugzilla.mozilla.org/show_bug.cgi?id=654550
user_pref("media.video_stats.enabled", false);
// 4611: [2509] disable touch events
   // fingerprinting attack vector - leaks screen res & actual screen coordinates
   // 0=disabled, 1=enabled, 2=autodetect
   // [WARNING] [SETUP] Optional protection depending on your device
   // [1] https://developer.mozilla.org/docs/Web/API/Touch_events
   // [2] https://trac.torproject.org/projects/tor/ticket/10286
   // user_pref("dom.w3c_touch_events.enabled", 0);
// * * * /
// FF58+
// 4612: [new] set a default permission for Location (FF58+)
   // [SETTING] to add site exceptions: Page Info>Permissions>Access Your Location
   // [SETTING] to manage site exceptions: Options>Privacy>Permissions>Location>Settings
   // user_pref("permissions.default.geo", 2); // 0=always ask (default), 1=allow, 2=block
// * * * /
// ***/

/*** 4700: RFP (4500) ALTERNATIVES - NAVIGATOR / USER AGENT (UA) SPOOFING
     Spoofing your UA to *LOWER* entropy *does* *not* *work*. It may even cause site breakage
     depending on your values. Even if you spoof, like TBB (Tor Browser Bundle) does, as the
     latest ESR, it still *does* *not* *work*. There are two main reasons for this.
       1. Many of the components that make up your UA can be derived by other means. And when
          those values differ, you provide more bits and raise entropy. Examples of leaks include
          navigator objects, date locale/formats, iframes, headers, resource://URIs,
          feature detection and more.
       2. You are not in a controlled set of significant numbers, where the values are enforced
          by default. It works for TBB because for TBB, the spoofed values ARE their default.
     * We do not recommend UA spoofing yourself, leave it to privacy.resistFingerprinting (see 4500)
       which is already plugging leaks (see 1 above) the prefs below do not address
     * Values below are for example only based on the current TBB at the time of writing
***/
user_pref("_user.js.parrot", "4700 syntax error: the parrot's taken 'is last bow");
/* 4701: navigator.userAgent leaks in JS
 * [NOTE] Setting this will break any UA spoofing extension whitelisting ***/
   // user_pref("general.useragent.override", "Mozilla/5.0 (Windows NT 6.1; rv:52.0) Gecko/20100101 Firefox/52.0"); // (hidden pref)
/* 4702: navigator.buildID (see gecko.buildID in about:config) reveals build time
 * down to the second which defeats user agent spoofing and can compromise OS etc
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=583181 ***/
   // user_pref("general.buildID.override", "20100101"); // (hidden pref)
/* 4703: navigator.appName ***/
   // user_pref("general.appname.override", "Netscape"); // (hidden pref)
/* 4704: navigator.appVersion ***/
   // user_pref("general.appversion.override", "5.0 (Windows)"); // (hidden pref)
/* 4705: navigator.platform leaks in JS ***/
   // user_pref("general.platform.override", "Win32"); // (hidden pref)
/* 4706: navigator.oscpu leaks in JS ***/
   // user_pref("general.oscpu.override", "Windows NT 6.1"); // (hidden pref)
/* 4707: general.useragent.locale (related, see 0204 deprecated FF59+) ***/

/*** 5000: PERSONAL SETTINGS [SETUP]
     Settings that are handy to migrate and/or are not in the Options interface. Users
     can put their own non-security/privacy/fingerprinting/tracking stuff here ***/
user_pref("_user.js.parrot", "5000 syntax error: this is an ex-parrot!");
/* 5001: disable annoying warnings ***/
user_pref("browser.tabs.warnOnClose", false);
user_pref("browser.tabs.warnOnCloseOtherTabs", false);
user_pref("browser.tabs.warnOnOpen", false);
/* 5002: disable warning when a domain requests full screen
 * [1] https://developer.mozilla.org/docs/Web/API/Fullscreen_API ***/
   // user_pref("full-screen-api.warning.delay", 0);
   // user_pref("full-screen-api.warning.timeout", 0);
/* 5003: disable closing browser with last tab ***/
user_pref("browser.tabs.closeWindowWithLastTab", false);
/* 5004: disable backspace (0=previous page, 1=scroll up, 2=do nothing) ***/
user_pref("browser.backspace_action", 2);
/* 5005: disable autocopy default [LINUX] ***/
   // user_pref("clipboard.autocopy", false);
/* 5006: disable enforced extension signing (FF43+)
 * [NOTE] Only applicable to Nightly and ESR (FF48+)
 * [1] https://wiki.mozilla.org/Add-ons/Extension_Signing#Documentation ***/
   // user_pref("xpinstall.signatures.required", false);
/* 5007: open new windows in a new tab instead
 * 1=current window, 2=new window, 3=most recent window
 * [SETTING] Options>General>Tabs>Open new windows in a new tab instead ***/
user_pref("browser.link.open_newwindow", 3);
/* 5008: open bookmarks in a new tab (FF57+)
 * [NOTE] You can also use middle-click, cmd/ctl-click, and use the context menu ***/
   // user_pref("browser.tabs.loadBookmarksInTabs", true);
/* 5010: enable ctrl-tab previews ***/
user_pref("browser.ctrlTab.previews", true);
/* 5011: don't open "page/selection source" in a tab. The window used instead is cleaner
 * and easier to use and move around (e.g. developers/multi-screen). ***/
user_pref("view_source.tab", false);
/* 5012: control spellchecking: 0=none, 1-multi-line controls, 2=multi-line & single-line controls ***/
user_pref("layout.spellcheckDefault", 1);
/* 5013: disable automatic "Work Offline" status
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=620472
 * [2] https://developer.mozilla.org/docs/Online_and_offline_events ***/
user_pref("network.manage-offline-status", false);
/* 5014: control download button visibility (FF57+)
 * true = the button is automatically shown/hidden based on whether the session has downloads or not
 * false = the button is always visible ***/
   // user_pref("browser.download.autohideButton", false);
/* 5015: disable animations (FF55+)
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1352069 ***/
   // user_pref("toolkit.cosmeticAnimations.enabled", false);
/* 5016: disable reload/stop animation (FF56+) ***/
   // user_pref("browser.stopReloadAnimation.enabled", true);
/* 5018: set maximum number of daily bookmark backups to keep (default is 15) ***/
user_pref("browser.bookmarks.max_backups", 2);
/* 5020: control urlbar click behaviour (with defaults) ***/
user_pref("browser.urlbar.clickSelectsAll", true);
user_pref("browser.urlbar.doubleClickSelectsAll", false);
/* 5021a: control tab behaviours (with defaults)
 * open links in a new tab immediately to the right of parent tab, not far right ***/
user_pref("browser.tabs.insertRelatedAfterCurrent", true);
/* 5021b: switch to the parent tab (if it has one) on close, rather than
 * to the adjacent right tab if it exists or to the adjacent left tab if it doesn't.
 * [NOTE] Requires browser.link.open_newwindow set to 3 (see pref 5007) ***/
user_pref("browser.tabs.selectOwnerOnClose", true);
/* 5021c: stay on the parent tab when opening links in a new tab
 * [SETTING] Options>General>Tabs>When you open a link in a new tab, switch to it immediately ***/
user_pref("browser.tabs.loadInBackground", true);
/* 5021d: set behavior of pages normally meant to open in a new window (such as target="_blank"
 * or from an external program), but that have instead been loaded in a new tab.
 * true: load the new tab in the background, leaving focus on the current tab
 * false: load the new tab in the foreground, taking the focus from the current tab. ***/
user_pref("browser.tabs.loadDivertedInBackground", false);
/* 5023: enable "Find As You Type"
 * [1] http://kb.mozillazine.org/Accessibility.typeaheadfind ***/
   // user_pref("accessibility.typeaheadfind", true);
/* 5026: disable "Reader View" ***/
   // user_pref("reader.parse-on-load.enabled", false);
/* 5027: decode URLs on copy from the urlbar (FF53+)
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1320061 ***/
user_pref("browser.urlbar.decodeURLsOnCopy", true);
/* 5028: disable middle-click enabling auto-scrolling [WINDOWS] [MAC] ***/
   // user_pref("general.autoScroll", false);

/*** 9999: DEPRECATED / REMOVED / LEGACY / RENAMED
     Documentation denoted as [-]. Numbers may be re-used. See [1] for a link-clickable,
     viewer-friendly version of the deprecated bugzilla tickets. The original state of each pref
     has been preserved, or changed to match the current setup, but you are advised to review them.
     [NOTE] Up to FF53, to enable a section change /* FFxx to // FFxx
     For FF53 on, we have bundled releases to cater for ESR. Change /* to // on the first line
     [1] https://github.com/ghacksuserjs/ghacks-user.js/issues/123
***/
user_pref("_user.js.parrot", "9999 syntax error: the parrot's deprecated!");
/* FF42 and older
// 2607: (25+) disable page thumbnails - replaced by browser.pagethumbnails.capturing_disabled
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=897811
user_pref("pageThumbs.enabled", false);
// 2503: (31+) disable network API - replaced by dom.netinfo.enabled
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=960426
user_pref("dom.network.enabled", false);
// 2620: (35+) disable WebSockets
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1091016
user_pref("network.websocket.enabled", false);
// 1610: (36+) set DNT "value" to "not be tracked" (FF21+)
   // [1] http://kb.mozillazine.org/Privacy.donottrackheader.value
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1042135#c101
   // user_pref("privacy.donottrackheader.value", 1);
// 2023: (37+) disable camera autofocus callback
   // The API will be superseded by the WebRTC Capture and Stream API
   // [1] https://developer.mozilla.org/docs/Archive/B2G_OS/API/CameraControl
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1107683
user_pref("camera.control.autofocus_moving_callback.enabled", false);
// 0415: (41+) disable reporting URLs (safe browsing) - removed or replaced by various
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1109475
user_pref("browser.safebrowsing.reportErrorURL", ""); // browser.safebrowsing.reportPhishMistakeURL
user_pref("browser.safebrowsing.reportGenericURL", ""); // removed
user_pref("browser.safebrowsing.reportMalwareErrorURL", ""); // browser.safebrowsing.reportMalwareMistakeURL
user_pref("browser.safebrowsing.reportMalwareURL", ""); // removed
user_pref("browser.safebrowsing.reportURL", ""); // removed
// 1804: (41+) disable plugin enumeration
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1169945
user_pref("plugins.enumerable_names", "");
// 2614: (41+) disable HTTP2 (draft)
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1132357
user_pref("network.http.spdy.enabled.http2draft", false);
// 2803: (42+) clear passwords on shutdown
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1102184
   // user_pref("privacy.clearOnShutdown.passwords", false);
// 5002: (42+) disable warning when a domain requests full screen
   // replaced by setting full-screen-api.warning.timeout to zero
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1160017
   // user_pref("full-screen-api.approval-required", false);
// ***/
/* FF43
// 0410's: disable safebrowsing urls & updates - replaced by various
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1107372
   // user_pref("browser.safebrowsing.gethashURL", ""); // browser.safebrowsing.provider.google.gethashURL
   // user_pref("browser.safebrowsing.updateURL", ""); // browser.safebrowsing.provider.google.updateURL
user_pref("browser.safebrowsing.malware.reportURL", ""); // browser.safebrowsing.provider.google.reportURL
// 0420's: disable tracking protection - replaced by various
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1107372
   // user_pref("browser.trackingprotection.gethashURL", ""); // browser.safebrowsing.provider.mozilla.gethashURL
   // user_pref("browser.trackingprotection.updateURL", ""); // browser.safebrowsing.provider.mozilla.updateURL
// 1803: remove plugin finder service
   // [1] http://kb.mozillazine.org/Pfs.datasource.url
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1202193
user_pref("pfs.datasource.url", "");
// 5003: disable new search panel UI
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1119250
   // user_pref("browser.search.showOneOffButtons", false);
// ***/
/* FF44
// 0414: disable safebrowsing's real-time binary checking (google) (FF43+)
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1237103
user_pref("browser.safebrowsing.provider.google.appRepURL", ""); // browser.safebrowsing.appRepURL
// 1200's: block rc4 whitelist
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1215796
user_pref("security.tls.insecure_fallback_hosts.use_static_list", false);
// 2301: disable SharedWorkers
   // [1] https://trac.torproject.org/projects/tor/ticket/15562
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1207635
user_pref("dom.workers.sharedWorkers.enabled", false);
// 2403: disable scripts changing images
   // [TEST] https://www.w3schools.com/jsref/tryit.asp?filename=tryjsref_img_src2
   // [WARNING] Will break some sites such as Google Maps and a lot of web apps
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=773429
   // user_pref("dom.disable_image_src_set", true);
// ***/
/* FF45
// 1021b: disable deferred level of storing extra session data 0=all 1=http-only 2=none
   // extra session data contains contents of forms, scrollbar positions, cookies and POST data
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1235379
user_pref("browser.sessionstore.privacy_level_deferred", 2);
// ***/
/* FF46
// 0333a: disable health report
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1234526
user_pref("datareporting.healthreport.service.enabled", false); // (hidden pref)
user_pref("datareporting.healthreport.documentServerURI", ""); // (hidden pref)
// 0334b: disable FHR (Firefox Health Report) v2 data being sent to Mozilla servers
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1234522
user_pref("datareporting.policy.dataSubmissionEnabled.v2", false);
// 0414: disable safebrowsing pref - replaced by browser.safebrowsing.downloads.remote.url
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1239587
user_pref("browser.safebrowsing.appRepURL", ""); // Google application reputation check
// 0420: disable polaris (part of Tracking Protection, never used in stable)
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1235565
   // user_pref("browser.polaris.enabled", false);
// 0510: disable "Pocket" - replaced by extensions.pocket.*
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1215694
user_pref("browser.pocket.enabled", false);
user_pref("browser.pocket.api", "");
user_pref("browser.pocket.site", "");
user_pref("browser.pocket.oAuthConsumerKey", "");
// ***/
/* FF47
// 0330b: set unifiedIsOptIn to make sure telemetry respects OptIn choice and that telemetry
   // is enabled ONLY for people that opted into it, even if unified Telemetry is enabled
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1236580
user_pref("toolkit.telemetry.unifiedIsOptIn", true); // (hidden pref)
// 0333b: disable about:healthreport page UNIFIED
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1236580
user_pref("datareporting.healthreport.about.reportUrlUnified", "data:text/plain,");
// 0807: disable history manipulation
   // [1] https://developer.mozilla.org/docs/Web/API/History_API
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1249542
user_pref("browser.history.allowPopState", false);
user_pref("browser.history.allowPushState", false);
user_pref("browser.history.allowReplaceState", false);
// ***/
/* FF48
// 0806: disable 'unified complete': 'Search with [default search engine]'
   // [-] http://techdows.com/2016/05/firefox-unified-complete-aboutconfig-preference-removed.html
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1181078
user_pref("browser.urlbar.unifiedcomplete", false);
// ***/
/* FF49
// 0372: disable "Hello"
   // [1] https://www.mozilla.org/privacy/archive/hello/2016-03/
   // [2] https://security.stackexchange.com/questions/94284/how-secure-is-firefox-hello
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1287827
user_pref("loop.enabled", false);
user_pref("loop.server", "");
user_pref("loop.feedback.formURL", "");
user_pref("loop.feedback.manualFormURL", "");
user_pref("loop.facebook.appId", "");
user_pref("loop.facebook.enabled", false);
user_pref("loop.facebook.fallbackUrl", "");
user_pref("loop.facebook.shareUrl", "");
user_pref("loop.logDomains", false);
// 2202: disable new window scrollbars being hidden
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1257887
user_pref("dom.disable_window_open_feature.scrollbars", true);
// 2303: disable push notification (UDP wake-up)
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1265914
user_pref("dom.push.udp.wakeupEnabled", false);
// ***/
/* FF50
// 0101: disable Windows10 intro on startup [WINDOWS]
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1274633
user_pref("browser.usedOnWindows10.introURL", "");
// 0308: disable plugin update notifications
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1277905
user_pref("plugins.update.notifyUser", false);
// 0410: disable "Block dangerous and deceptive content" - replaced by browser.safebrowsing.phishing.enabled
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1025965
   // user_pref("browser.safebrowsing.enabled", false);
// 1266: disable rc4 ciphers
   // [1] https://trac.torproject.org/projects/tor/ticket/17369
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1268728
   // [-] https://www.fxsitecompat.com/en-CA/docs/2016/rc4-support-has-been-completely-removed/
user_pref("security.ssl3.ecdhe_ecdsa_rc4_128_sha", false);
user_pref("security.ssl3.ecdhe_rsa_rc4_128_sha", false);
user_pref("security.ssl3.rsa_rc4_128_md5", false);
user_pref("security.ssl3.rsa_rc4_128_sha", false);
// 1809: remove Mozilla's plugin update URL
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1277905
user_pref("plugins.update.url", "");
// ***/
/* FF51
// 1851: delay play of videos until they're visible
   // [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1180563
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1262053
user_pref("media.block-play-until-visible", true);
// 2504: disable virtual reality devices
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1250244
user_pref("dom.vr.oculus050.enabled", false);
// 2614: disable SPDY
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1248197
user_pref("network.http.spdy.enabled.v3-1", false);
// ***/
/* FF52
// 1601: disable referer from an SSL Website
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1308725
user_pref("network.http.sendSecureXSiteReferrer", false);
// 1850: disable Adobe EME "Primetime CDM" (Content Decryption Module)
   // [1] https://trac.torproject.org/projects/tor/ticket/16285
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1329538 // FF52
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1337121 // FF52
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1329543 // FF53
user_pref("media.gmp-eme-adobe.enabled", false);
user_pref("media.gmp-eme-adobe.visible", false);
user_pref("media.gmp-eme-adobe.autoupdate", false);
// 2405: disable WebTelephony API
   // [1] https://wiki.mozilla.org/WebAPI/Security/WebTelephony
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1309719
user_pref("dom.telephony.enabled", false);
// 2502: disable Battery Status API
   // Initially a Linux issue (high precision readout) that was fixed.
   // However, it is still another metric for fingerprinting, used to raise entropy.
   // e.g. do you have a battery or not, current charging status, charge level, times remaining etc
   // [1] https://techcrunch.com/2015/08/04/battery-attributes-can-be-used-to-track-web-users/
   // [2] https://bugzilla.mozilla.org/show_bug.cgi?id=1124127
   // [3] https://www.w3.org/TR/battery-status/
   // [4] https://www.theguardian.com/technology/2016/aug/02/battery-status-indicators-tracking-online
   // [NOTE] From FF52+ Battery Status API is only available in chrome/privileged code.
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1313580
user_pref("dom.battery.enabled", false);
// ***/

/* ESR52.x still uses all the following prefs
// [NOTE] replace the * with a slash in the line above to re-enable them if you're using ESR52.x.x
// FF53
// 1265: block rc4 fallback
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1130670
user_pref("security.tls.unrestricted_rc4_fallback", false);
// 1806: disable Acrobat, Quicktime, WMP (the string = min version number allowed)
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1317109
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1317110
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1317108
user_pref("plugin.scan.Acrobat", "99999");
user_pref("plugin.scan.Quicktime", "99999");
user_pref("plugin.scan.WindowsMediaPlayer", "99999");
// 2022: disable screensharing
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1329562
user_pref("media.getusermedia.screensharing.allow_on_old_platforms", false);
// 2507: disable keyboard fingerprinting
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1322736
user_pref("dom.beforeAfterKeyboardEvent.enabled", false);
// * * * /
// FF54
// 0415: disable reporting URLs (safe browsing)
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1288633
user_pref("browser.safebrowsing.reportMalwareMistakeURL", "");
user_pref("browser.safebrowsing.reportPhishMistakeURL", "");
// 1830: block websites detecting DRM is disabled
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1242321
user_pref("media.eme.apiVisible", false);
// 2425: disable Archive Reader API
   // i.e. reading archive contents directly in the browser, through DOM file objects
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1342361
user_pref("dom.archivereader.enabled", false);
// * * * /
// FF55
// 0209: disable geolocation on non-secure origins (FF54+)
   // [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1269531
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1072859
user_pref("geo.security.allowinsecure", false);
// 0336: disable "Heartbeat" (Mozilla user rating telemetry) (FF37+)
   // [1] https://trac.torproject.org/projects/tor/ticket/18738
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1361578
user_pref("browser.selfsupport.enabled", false); // (hidden pref)
user_pref("browser.selfsupport.url", "");
// 0360: disable new tab "pings"
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1241390
user_pref("browser.newtabpage.directory.ping", "data:text/plain,");
// 0861: disable saving form history on secure websites
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1361220
user_pref("browser.formfill.saveHttpsForms", false);
// 0863: disable Form Autofill (FF54+) - replaced by extensions.formautofill.*
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1364334
user_pref("browser.formautofill.enabled", false);
// 2410: disable User Timing API
   // [1] https://trac.torproject.org/projects/tor/ticket/16336
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1344669
user_pref("dom.enable_user_timing", false);
// 2507: disable keyboard fingerprinting (FF38+) (physical keyboards)
   // The Keyboard API allows tracking the "read parameter" of pressed keys in forms on
   // web pages. These parameters vary between types of keyboard layouts such as QWERTY,
   // AZERTY, Dvorak, and between various languages, e.g. German vs English.
   // [WARNING] Don't use if Android + physical keyboard
   // [1] https://developer.mozilla.org/docs/Web/API/KeyboardEvent/code
   // [2] https://www.privacy-handbuch.de/handbuch_21v.htm
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1352949
user_pref("dom.keyboardevent.code.enabled", false);
// 5015: disable tab animation - replaced by toolkit.cosmeticAnimations.enabled
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1352069
user_pref("browser.tabs.animate", false);
// 5016: disable fullscreeen animation - replaced by toolkit.cosmeticAnimations.enabled
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1352069
user_pref("browser.fullscreen.animate", false);
// * * * /
// FF56
// 0515: disable Screenshots (rollout pref only) (FF54+)
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1386333
   // user_pref("extensions.screenshots.system-disabled", true);
// 0517: disable Form Autofill (FF55+) - replaced by extensions.formautofill.available
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1385201
user_pref("extensions.formautofill.experimental", false);
// * * * /
// FF57
// 0374: disable "social" integration
   // [1] https://developer.mozilla.org/docs/Mozilla/Projects/Social_API
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1388902
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1406193 (leftover prefs removed in FF58)
user_pref("social.whitelist", "");
user_pref("social.toast-notifications.enabled", false);
user_pref("social.shareDirectory", "");
user_pref("social.remote-install.enabled", false);
user_pref("social.directories", "");
user_pref("social.share.activationPanelEnabled", false);
user_pref("social.enabled", false); // (hidden pref)
// 1830: disable DRM's EME WideVineAdapter
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1395468
user_pref("media.eme.chromium-api.enabled", false); // (FF55+)
// 2611: disable WebIDE extension downloads (Valence)
   // [1] https://trac.torproject.org/projects/tor/ticket/16222
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1393497
user_pref("devtools.webide.autoinstallFxdtAdapters", false);
// 2612: disable SimpleServiceDiscovery - which can bypass proxy settings - e.g. Roku
   // [1] https://trac.torproject.org/projects/tor/ticket/16222
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1393582
user_pref("browser.casting.enabled", false);
// 5022: hide recently bookmarked items (you still have the original bookmarks) (FF49+)
   // [-] https://bugzilla.mozilla.org/show_bug.cgi?id=1401238
user_pref("browser.bookmarks.showRecentlyBookmarked", false);
// * * * /
// ***/

/* 0101 */
user_pref("browser.laterrun.enabled", true);
/* 0102 */
user_pref("browser.startup.page", 3);
/* 0801 */
user_pref("keyword.enabled", true);
/* 0804 */
user_pref("browser.sessionhistory.max_entries", 50);
/* 0850a */
user_pref("browser.urlbar.autocomplete.enabled", true);
user_pref("browser.urlbar.suggest.history", true);
user_pref("browser.urlbar.suggest.bookmark", true);
user_pref("browser.urlbar.suggest.openpage", true);
/* 0850c */
user_pref("browser.urlbar.autoFill", true);
user_pref("browser.urlbar.autoFill.typed", true);
/* 0860 */
user_pref("browser.formfill.enable", true);
/* 1020 */
user_pref("browser.sessionstore.max_tabs_undo", 20);
user_pref("browser.sessionstore.max_windows_undo", 3);
/* 1021 */
user_pref("browser.sessionstore.resume_from_crash", true);
/* 1401 */
user_pref("browser.display.use_document_fonts", 1);
/* 2418 */
user_pref("full-screen-api.enabled", true);
/* 2603 */
user_pref("browser.download.useDownloadDir", true);
/* 2701 */
user_pref("network.cookie.cookieBehavior", 0);
/* 2802 */
user_pref("privacy.sanitize.sanitizeOnShutdown", false);
/* 2803 */
user_pref("privacy.clearOnShutdown.cache", false);
user_pref("privacy.clearOnShutdown.cookies", false);
user_pref("privacy.clearOnShutdown.downloads", true);
user_pref("privacy.clearOnShutdown.formdata", false);
user_pref("privacy.clearOnShutdown.history", false);
user_pref("privacy.clearOnShutdown.offlineApps", false);
user_pref("privacy.clearOnShutdown.sessions", false);
user_pref("privacy.clearOnShutdown.siteSettings", false);
/* 5003 */
user_pref("browser.tabs.closeWindowWithLastTab", true);
/* 5021d */
user_pref("browser.tabs.loadDivertedInBackground", true);

/* END: internal custom pref to test for syntax errors ***/
user_pref("_user.js.parrot", "SUCCESS: No no he's not dead, he's, he's restin'!");
