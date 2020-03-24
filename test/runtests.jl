using Test, Documenter, WebDriver
using WebDriver: StatusError
DocMeta.setdocmeta!(WebDriver, :DocTestSetup, :(using WebDriver), recursive = true)

ENV["WEBDRIVER_HOST"] = get(ENV, "WEBDRIVER_HOST", "localhost")
ENV["WEBDRIVER_PORT"] = get(ENV, "WEBDRIVER_PORT", "4444")

@testset "WebDriver" begin
    doctest(WebDriver)
end

capabilities = Capabilities("chrome")
@test isa(capabilities, Capabilities)
wd = RemoteWebDriver(
    capabilities,
    host = ENV["WEBDRIVER_HOST"],
    port = parse(Int, ENV["WEBDRIVER_PORT"]),
)
# New Session
session = Session(wd)
@test isa(session, Session)
# Delete Session
@test delete!(session) == session.id
@test_throws WDError delete!(session)
session = Session(wd)
# Status
@test status(wd)
# Get Timeouts
@test_broken timeouts(session)
# Set Timeouts
@inferred timeouts!(session, Timeouts(implicit = 50))
@inferred timeouts!(session, Timeouts())
# Navigate To
start_url = current_url(session)
@inferred navigate!(session, "http://thedemosite.co.uk/addauser.php")
# Get Current URL
@test current_url(session) == "http://thedemosite.co.uk/addauser.php"
# Back
back!(session)
@test current_url(session) == start_url
# Forward
forward!(session)
@test current_url(session) == "http://thedemosite.co.uk/addauser.php"
# Refresh
@inferred refresh!(session)
# Get Title
@test document_title(session) == "Add a user - FREE PHP code and SQL"
# Get Window Handle
@inferred window_handle(session)
# Close Window
@inferred window_close!(session)
delete!(session)
session = Session(wd)
# Switch to Window
window!(session, window_handle(session))
# Get Window Handles
@inferred window_handles(session)
# New Window
@test_broken window!(session)
# Switch to Frame
# @inferred frame!(session, window_handle(session))
# Switch to Parent Frame
@inferred parent_frame!(session)
# Get Window Rect
@inferred rect(session)
# Set Window Rect
@test_broken rect!(session, width = 600)
# Maximize Window
@inferred maximize!(session)
# Minimize Window
@test_throws StatusError minimize!(session)
# Get Active Element
@inferred active_element(session)
# Find Element
navigate!(session, "http://book.theautomatedtester.co.uk/chapter1")
selecttype = Element(session, "xpath", """//select[@id='selecttype']""")
@test isa(selecttype, Element)
# Find Elements
selecttypes = Elements(session, "xpath", """//select[@id='selecttype']""")
@test isa(selecttypes, AbstractVector{<:Element})
# Find Element From Element
t1selenium = Element(selecttype, "xpath", """//option[@value='Selenium IDE']""")
# Find Elements from Element
tsselenium = Elements(selecttype, "xpath", """//option""")
# Is Element Selected
@test_broken isselected(selecttype)
# Get Element Attribute
@test element_attr(t1selenium, "value") == "Selenium IDE"
# Get Element Property
@test element_property(t1selenium, "value") == "Selenium IDE"
# Get Element CSS Value
@test element_css(selecttype, "font-size") == "13.3333px"
# Get Element Text
@test element_text(t1selenium) == element_attr(t1selenium, "value")
# Get Element Tag Name
@test element_tag(selecttype) == "select"
# Get Element Rect
@inferred rect(selecttype)
# Is Element Enabled
@test isenabled(selecttype)
# Element Click
radiobutton = Element(session, "xpath", """//input[@id='radiobutton']""")
@test !element_property(radiobutton, "checked")
@inferred click!(radiobutton)
@test element_property(radiobutton, "checked")
# Element Clear
text_box = Element(session, "xpath", """//*[@id='html5div']""")
@test element_text(text_box) == "To be used after the AJAX section of the book"
@inferred clear!(text_box)
@test isempty(element_text(text_box))
# Element Send Keys
element_keys!(text_box, "All your base are belong to us")
@test element_text(text_box) == "All your base are belong to us"
# Get Page Source
@inferred source(session);
# Execute Script
navigate!(session, "http://book.theautomatedtester.co.uk/chapter1")
selecttype = Element(session, "xpath", """//select[@id='selecttype']""")
@test element_attr(selecttype, "value") == "Selenium IDE"
script!(session, "arguments[0].value = arguments[1];", selecttype, "Selenium Grid")
@test element_attr(selecttype, "value") == "Selenium Grid"
# Get All Cookies
navigate!(session, "http://book.theautomatedtester.co.uk/chapter8")
@test length(cookies(session)) == 1
# Get Named Cookie
second_cookie = Element(session, "xpath", "//input[@id='secondCookie']")
click!(second_cookie)
@test cookie(session, "visitorCount").name == "visitorCount"
# Add Cookie
@inferred cookie!(session, Cookie("WhoIsAwesome", "ME!"))
@test cookie(session, "WhoIsAwesome").value == "ME!"
# Delete Cookie
@inferred delete!(session, "")
@inferred cookies(session)
# Perform Actions (Untested)
navigate!(session, "http://book.theautomatedtester.co.uk/chapter4")
hoverOver = Element(session, "xpath", "//*[@id='hoverOver']")
@inferred moveto!(hoverOver)
# User Prompts
# Get alert_text Text
@inferred alert_text(session) == "on MouseOver worked"
# Dismiss alert_text
@inferred dismiss(session)
@test_throws StatusError alert_text(session)
# Accept alert_text
navigate!(session, "http://book.theautomatedtester.co.uk/chapter4")
hoverOver = Element(session, "xpath", "//*[@id='hoverOver']")
@inferred moveto!(hoverOver)
@inferred alert_text(session) == "on MouseOver worked"
@inferred accept(session)
# Click button
navigate!(session, "https://www.w3schools.com/jsref/tryit.asp?filename=tryjsref_prompt")
button = Element(session, "css selector", "body > div.trytopnav > div > button")
@inferred click!(button)
# Change frames
example_frame = Element(session, "xpath", "//*[@name='iframeResult']")
frame!(example_frame)
button = Element(session, "xpath", "/html/body/button")
@inferred click!(button)
@inferred alert_text(session)
alert_text!(session, "Nosferican")
@inferred accept(session)
my_name = Element(session, "xpath", "//*[@id='demo']")
@test @inferred element_text(my_name) == "Hello Nosferican! How are you today?"
delete!(session)
