"""
    WebDriver

A binding for the [WebDriver](https://w3c.github.io/webdriver) and [JSON Wire Protocol](https://github.com/SeleniumHQ/selenium/wiki/JsonWireProtocol) for the Julia programing language compatible with the Selenium [WebDriver](https://selenium.dev/documentation/en/webdriver).

[Repository](https://github.com/Nosferican/WebDriver.jl)

# Example
```jldoctest
julia> using WebDriver
```
"""
module WebDriver
    using Base.Filesystem: realpath
    using Base.Iterators: flatten
    using Dates: DateTime, datetime2unix, unix2datetime
    using HTTP: HTTP, URI, escapeuri, ExceptionRequest.StatusError
    using JSON3: JSON3, Object
    using Parameters: @unpack
    import Base: show, delete!, getproperty, summary
    import Base.Broadcast: broadcastable
    ENV["WEBDRIVER_HOST"] = get(ENV, "WEBDRIVER_HOST", "selenium")
    ENV["WEBDRIVER_PORT"] = get(ENV, "WEBDRIVER_PORT", "4444")
    for (root, dirs, files) ∈ walkdir(joinpath(@__DIR__))
        foreach(file -> include(joinpath(root, file)), filter!(file -> occursin(r"^\d{2}_\w+\.jl$", file), files))
    end
    export
        # Structs
        Timeouts,
        Proxy,
        Capabilities,
        RemoteWebDriver,
        Session,
        Element,
        WDError,
        Cookie,
        # Commands
        status,
        timeouts,
        timeouts!,
        navigate!,
        current_url,
        back!,
        forward!,
        refresh!,
        document_title,
        window_handle,
        window_close!,
        window!,
        window_handles,
        frame!,
        parent_frame!,
        rect,
        rect!,
        maximize!,
        minimize!,
        active_element,
        Elements,
        isselected,
        element_attr,
        element_css,
        element_text,
        element_tag,
        element_property,
        isenabled,
        click!,
        clear!,
        element_keys!,
        source,
        script!,
        cookie,
        cookies,
        cookie!,
        cookies!,
        moveto!,
        dismiss,
        accept,
        alert_text,
        alert_text!,
        screenshot,
        sessions
end
