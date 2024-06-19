# README


### Requirements

- [x] The grading machine will POST these documents to a HTTP endpoint at `/import`. The body of the request will be XML file content. They come with a content-type of `text/xml+markr`

    -   `mean` - the mean of the awarded marks
    -   `count` - the number of students who took the test
    -   `p25`, `p50`, `p75` - the 25th percentile, median, and 75th percentile scores
    - Note that the visualisation team require these numbers to be expressed as _percentages_ (i.e. as a float from 0 to 100) of the available marks in the test.
- [x] You may see a particular student's submission twice, and it will have a different score - just pick the highest one. You'll also need to do the same with the _available_ marks for the test.
- [x] These duplicate documents may come in a single request or in multiple requests.
- [x] Sometimes, the machines mess up and post you a document missing some important bits. When this happens, it's important that you reject the _entire_ document with an appropriate HTTP error. This causes the machine to print out the offending document (yes, print, as in, on paper) and some poor work experience kid then enters the whole thing manually. If you've already accepted part of the document, that'll cause some confusion which is _way_ above their paygrade.
- [ ] Although your boss _said_ this was just a working prototype for the board meeting, you have a sneaking suspicion it'll somehow find its way into production. Therefore, you figure you should at least take a swing at error handling and automated tests. Goodness knows you're not getting paid enough for 100% test coverage, but it's probably best if you at least put some tests around the basics.
- [ ] The current visualisation solution generates printed & (snail) mailed reports overnight, so the aggregate fetching doesn't need to be fast. However, you heard on the grape vine that part of the big fundraising round is going towards building real-time dashboards to be displayed at City Hall - so it's probably worth having a think about that & writing a few things down even if the prototype implementation you build is a bit slow.


Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...



Health Check Out of the Box
Dockerfile out of the box
All the Middleware Goodness
Already had some of the other setup from another app i've been working on
