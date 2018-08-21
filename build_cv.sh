#!/bin/bash

export PDFKIT_OUTFILE=$PWD/cv.pdf 

cd cv && bundle exec ruby build.rb
