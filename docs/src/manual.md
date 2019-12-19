# Manual

## Getting Started

You should first find a remote web driver for the package to connect.

For example, you could use a Docker image for spinning a container for a remote web driver such as

```
docker run -d -p 4444:4444 --name selenium selenium/standalone-chrome
```

which will run the Selenium standalone Google Chrome web driver.

We can connect to it from WebDriver.jl through the following steps,

1. We specify the requested web driver capabilities. The required argument being the browser name (`chrome`).

```@setup FirstSteps
ENV["WEBDRIVER_HOST"] = get(ENV, "WEBDRIVER_HOST", "selenium")
ENV["WEBDRIVER_PORT"] = get(ENV, "WEBDRIVER_PORT", "4444")
```

```@example FirstSteps
using WebDriver
capabilities = Capabilities("chrome")
```

We specify the remote driver we want to connect to,

The host will likely be `localhost` or the name of the container if in a container network (e.g., `selenium`).

The port will be that being exposed which by default is `4444`. In the example, above we mapped the container to listen at the port `4444`.

```@example FirstSteps
wd = RemoteWebDriver(capabilities, host = ENV["WEBDRIVER_HOST"], port = parse(Int, ENV["WEBDRIVER_PORT"]))
```

Create a session

Lastly, we can start a session in the webdriver.

```@example FirstSteps
status(wd) # Will check if server is running and available for new sessions
```

```@example FirstSteps
sessions(wd) # All active sessions
```

```@example FirstSteps
session = Session(wd) # Will create a new session
```

The session we just created is now active

```@example FirstSteps
sessions(wd)
```

After performing operations with that session, you may close it with

```@example FirstSteps
delete!(session)
```

We can confirm that the session was actually deleted.

```@example FirstSteps
sessions(wd)
```

For the following section, feel free to follow up the session actions in your browser.

## Navigation

```@setup Navigation
ENV["WEBDRIVER_HOST"] = get(ENV, "WEBDRIVER_HOST", "selenium")
ENV["WEBDRIVER_PORT"] = get(ENV, "WEBDRIVER_PORT", "4444")
```

```@example Navigation
using WebDriver
capabilities = Capabilities("chrome")
wd = RemoteWebDriver(capabilities, host = ENV["WEBDRIVER_HOST"], port = parse(Int, ENV["WEBDRIVER_PORT"]))
session = Session(wd)
```

We can query the current URL

```@example Navigation
current_url(session)
```

We can navigate to a different URL

```@example Navigation
navigate!(session, "http://thedemosite.co.uk/addauser.php")
current_url(session)
```

We can go back

```@example Navigation
back!(session)
current_url(session)
```

We can go forward

```@example Navigation
forward!(session)
current_url(session)
```

We can refresh

```@example Navigation
refresh!(session);
```

```@setup Navigation
delete!(session)
```

## Elements

```@setup Elements
ENV["WEBDRIVER_HOST"] = get(ENV, "WEBDRIVER_HOST", "selenium")
ENV["WEBDRIVER_PORT"] = get(ENV, "WEBDRIVER_PORT", "4444")
```

```@example Elements
using WebDriver
capabilities = Capabilities("chrome")
wd = RemoteWebDriver(capabilities, host = ENV["WEBDRIVER_HOST"], port = parse(Int, ENV["WEBDRIVER_PORT"]))
session = Session(wd)
```

We can find the active element

```@example Elements
active_element(session)
```

We can find an element based on `css selector`, `link text`, `partial link text`, `tag name` or `xpath`

```@example Elements
navigate!(session, "http://book.theautomatedtester.co.uk/chapter1")
selecttype = Element(session, "xpath", """//select[@id='selecttype']""") # Find first element
```

```@example Elements
selecttypes = Elements(session, "xpath", """//select[@id='selecttype']""") # Find all elements
```

```@example Elements
t1selenium = Element(selecttype, "xpath", """//option[@value='Selenium IDE']""") # Find Element From Element
```

```@example Elements
tsselenium = Elements(selecttype, "xpath", """//option""") # Find Elements from Element
```

We can query elements for attributes, properties, tag, text, css values, dimensions, etc.

```@example Elements
element_attr(t1selenium, "value") # Get Element Attribute
```

```@example Elements
element_property(t1selenium, "value") # Get Element Property
```

```@example Elements
element_css(selecttype, "font-size") # Get Element CSS Value
```

```@example Elements
element_text(t1selenium) # Get Element Text
```

```@example Elements
element_tag(selecttype) # Get Element Tag Name
```

```@example Elements
rect(selecttype) # Get Element Rect
```

```@example Elements
isenabled(selecttype) # Is the element enabled
```

Clicking elements

```@example Elements
radiobutton = Element(session, "xpath", """//input[@id='radiobutton']""")
```

```@example Elements
element_property(radiobutton, "checked")
```

```@example Elements
click!(radiobutton) # Element Click
```

```@example Elements
element_property(radiobutton, "checked")
```

Text boxes

```@example Elements
text_box = Element(session, "xpath", """//*[@id='html5div']""")
```

```@example Elements
element_text(text_box)
```

```@example Elements
clear!(text_box) # Element Clear
element_text(text_box)
```

```@example Elements
element_keys!(text_box, "All your base are belong to us") # Element Send Keys
element_text(text_box)
```

```@setup Elements
delete!(session) # hide
```

## Page Source

```@setup PageSource
ENV["WEBDRIVER_HOST"] = get(ENV, "WEBDRIVER_HOST", "selenium")
ENV["WEBDRIVER_PORT"] = get(ENV, "WEBDRIVER_PORT", "4444")
```

```@example PageSource
using WebDriver, Gumbo, Cascadia
capabilities = Capabilities("chrome")
wd = RemoteWebDriver(capabilities, host = ENV["WEBDRIVER_HOST"], port = parse(Int, ENV["WEBDRIVER_PORT"]))
session = Session(wd)
```

```@example PageSource
navigate!(session, "http://book.theautomatedtester.co.uk/chapter1")
html = parsehtml(source(session))
eachmatch(Selector("#selecttype"), html.root)
```

```@setup PageSource
delete!(session) # hide
```

## Execute Script

```@setup Script
ENV["WEBDRIVER_HOST"] = get(ENV, "WEBDRIVER_HOST", "selenium")
ENV["WEBDRIVER_PORT"] = get(ENV, "WEBDRIVER_PORT", "4444")
```

```@example Script
using WebDriver, Gumbo, Cascadia
capabilities = Capabilities("chrome")
wd = RemoteWebDriver(capabilities, host = ENV["WEBDRIVER_HOST"], port = parse(Int, ENV["WEBDRIVER_PORT"]))
session = Session(wd)
```

```@example Script
navigate!(session, "http://book.theautomatedtester.co.uk/chapter1")
selecttype = Element(session, "xpath", """//select[@id='selecttype']""")
element_attr(selecttype, "value") == "Selenium IDE"
```

```@example Script
script!(session, "arguments[0].value = arguments[1];", selecttype, "Selenium Grid")
element_attr(selecttype, "value")
```

```@setup Script
delete!(session) # hide
```

## Cookies

```@setup Cookies
ENV["WEBDRIVER_HOST"] = get(ENV, "WEBDRIVER_HOST", "selenium")
ENV["WEBDRIVER_PORT"] = get(ENV, "WEBDRIVER_PORT", "4444")
```

```@example Cookies
using WebDriver, Gumbo, Cascadia
capabilities = Capabilities("chrome")
wd = RemoteWebDriver(capabilities, host = ENV["WEBDRIVER_HOST"], port = parse(Int, ENV["WEBDRIVER_PORT"]))
session = Session(wd)
```

Find all cookies

```@example Cookies
navigate!(session, "http://book.theautomatedtester.co.uk/chapter8")
length(cookies(session))
```

Get Named Cookie

```@example Cookies
second_cookie = Element(session, "xpath", "//input[@id='secondCookie']")
click!(second_cookie)
cookie(session, "visitorCount").name
```

Add a cookie

```@example Cookies
cookie!(session, Cookie("WhoIsAwesome", "ME!"))
cookie(session, "WhoIsAwesome").value
```

Delete Cookie

```@example Cookies
delete!(session, "WhoIsAwesome") # Deletes cookie of that name
delete!(session, "") # Deletes all cookies
length(cookies(session))
```

```@setup Cookies
delete!(session)
```

## More Advanced Features

This will go over user prompts, hoverover / move pointer to, changing frames, and screenshots

Let us first hover over and accept a user-prompt.

```@setup Advanced
ENV["WEBDRIVER_HOST"] = get(ENV, "WEBDRIVER_HOST", "selenium")
ENV["WEBDRIVER_PORT"] = get(ENV, "WEBDRIVER_PORT", "4444")
```

```@example Advanced
using WebDriver
capabilities = Capabilities("chrome")
wd = RemoteWebDriver(capabilities, host = ENV["WEBDRIVER_HOST"], port = parse(Int, ENV["WEBDRIVER_PORT"]))
session = Session(wd)
```

```@example Advanced
navigate!(session, "http://book.theautomatedtester.co.uk/chapter4")
hoverOver = Element(session, "xpath", "//*[@id='hoverOver']")
moveto!(hoverOver)
alert_text(session)
```

```@example Advanced
accept(session) # dismiss(session) would have also worked
```

We can also switch frames as in the following example,

```@example Advanced
navigate!(session, "https://www.w3schools.com/jsref/tryit.asp?filename=tryjsref_prompt")
button = Element(session, "css selector", "body > div.trytopnav > div > button")
click!(button)
```

```@example Advanced
example_frame = Element(session, "xpath", "//*[@name='iframeResult']")
frame!(example_frame)
button = Element(session, "xpath", "/html/body/button")
click!(button)
alert_text(session)
```

```@example Advanced
alert_text!(session, "Nosferican")
accept(session)
```

```@example Advanced
my_name = Element(session, "xpath", "//*[@id='demo']")
element_text(my_name)
```

```@example Advanced
using Base64
ss = write(joinpath(@__DIR__, "img.png"), base64decode(screenshot(session)))
```

```@setup Advanced
delete!(session)
```

## More Features

For more features, take a look at the API.
