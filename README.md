
Concurrent Sequential Processes
===============================

This library provides a concurrency framework based on the work of Tony Hoare
in his book ["Communicating Sequential Processes"](http://www.usingcsp.com/).


Usage
-----

With CSP, your problem is modelled by *processes* that run concurrently, but
are sequential internally. These processes communicate over *channels*, which
provide a simple messaging API.

    # Prints "Hello, World!" to stdout.
    chan = CSP::Channel.new
	CSP::Process.new { puts(chan.read) }.start
	CSP::Process.new { chan << "Hello, World!" }.start

Note that the process is blocked when trying to read on the channel, and only
resumes execution when it is able to read a value.
