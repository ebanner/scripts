#!/usr/bin/python3

import os
import sys
import argparse

extensions = (
    'mkv',
    'avi',
    'mp3',
    'wmv',
    'flv',
    'mp4',
    'divx',
    'ogm',
    'rm',
    'rmvb',
)
movies = []
output_file = 'movies.list'

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Create a list of movies')
    parser.add_argument('movie_dir', help='The parent directory of your movies')
    parser.add_argument(
        '-o', '--output-file', 
        help='The name of a file that will contain the movies',
        default='movies.list'
    )
    parser.add_argument(
        '-e', '--extension-file', 
        help='A file containing the extensions the user would like to have '
        'included in his or her movie search'
    )
    args = parser.parse_args()

    # Read extensions from a file if provided
    if args.extension_file:
      try:
        with open(args.extension_file, 'r') as f:
          extensions = [ line.strip() for line in f ]
      except IOError:
        print('Could not open {}. Exiting.'.format(args.extension_file))

    # Open the file for writing
    try:
        f = open(args.output_file, 'w')
    except IOError:
        print('Could not open {}. Exiting.'.format(args.output_file))
        sys.exit()

    # Write all movies that end with allowed extensions
    for root, dirs, files in os.walk(args.movie_dir):
        for file in files:
            if file.split('.')[-1].strip().lower() in extensions:
              f.write(file + "\n")
