# Copyright (C) 2021 DevLear - All Rights Reserved.
#
# This file is a part of BeerHub project.
#
# Confidential and Proprietary.
# Unauthorized copying of this file, via any medium is strictly prohibited.

import os
import sys
import shutil
import subprocess
import zipfile

#---------------------------------------------------------------------------------------------------
# The script for make a content.dat file for BeerHub app on Linux
# Author: Mikhail.Malakhov
#---------------------------------------------------------------------------------------------------

DEBUG = False

TMP_DIR = "tmp"

CRYPTO_DIR = "../external/crypto/bin"
CRYPTO_PATH_NIX = CRYPTO_DIR + "/crypto"
CRYPTO_PATH_WIN = CRYPTO_DIR + "/crypto.exe"

DATABASE_DIR = "../data"
DATABASE_FILE_DEBUG = "beer_hub_dev.db"
DATABASE_FILE_RELEASE = "beer_hub_1.0.db"

CONTENT_OUT_DIR = "out"
CONTENT_SOURCE_DIR = "source"

# Returns current working directory
def get_working_dir():
    return os.path.abspath(os.getcwd())


# Returns current output directory
def get_out_dir():
    return get_working_dir() + "/" + CONTENT_OUT_DIR


# Removes out directory
def remove_out():
    shutil.rmtree(get_out_dir(), True, None)


# Creates out directory
def make_out():
    os.makedirs(get_out_dir())


# Copy the database file
def copy_db(release):
    tmp = get_out_dir() + "/tmp"
    if not os.path.exists(tmp):
        os.makedirs(tmp)
    db_file = DATABASE_FILE_DEBUG
    if release:
        db_file = DATABASE_FILE_RELEASE
    db_file = DATABASE_DIR + "/" + db_file
    shutil.copy(db_file, tmp + "/data.db")
    print("Database - OK")
    if DEBUG :
        print("    file - " + os.path.basename(db_file))


# Zip specified dir
def zip_dir(path, zip_f):
    for root, dirs, files in os.walk(path):
        # Directories, at first
        for dir in dirs:
            zip_f.write(os.path.join(root, dir), 
                        os.path.relpath(os.path.join(root, dir), 
                        os.path.join(path, '.')))
        # Files
        for file in files:
            zip_f.write(os.path.join(root, file), 
                        os.path.relpath(os.path.join(root, file), 
                        os.path.join(path, '.')))
    print("Zip - OK")


# Encode content
def encode():
    # Check OS
    if os.name == "posix":    
        # crypto = get_working_dir() + "/tools/linux/crypto"
        crypto = get_working_dir() + "/" + CRYPTO_PATH_NIX
    elif os.name == "nt":
        # crypto = get_working_dir() + "/tools/win/crypto.exe"
        crypto = get_working_dir() + "/" + CRYPTO_PATH_WIN
    else:
        print("Crypto not found...")
        return
    # Encode
    process = subprocess.Popen([crypto, "-e", get_out_dir() + "/content.zip",
        get_out_dir() + "/content.dat"], stdout=subprocess.PIPE)
    (output, err) = process.communicate()
    exit_code = process.wait()
    if exit_code == 0:
        print("Encode - OK")
    else:
        print("Encode - FAIL - " + str(exit_code))

    if DEBUG :
        print("    crypto - " + crypto)


#---------------------------------------------------------------------------------------------------
# Functions that available from command line
#---------------------------------------------------------------------------------------------------

# Clear temporary files and dirs
def clear_all():
    remove_out()

#---------------------------------------------------------------------------------------------------
# Script entry point
#---------------------------------------------------------------------------------------------------

script_args = {
    "def", "-r", "-c", "-t"
}

if __name__ == '__main__':
    print(get_working_dir())

    # Parsing args
    release = False
    clear = False
    test = False
    arg = "def"
    if len(sys.argv) > 1:
        arg = sys.argv[1]
    if (not (arg in script_args)) :
        print("Wrong argument: " + arg)
        exit(-1)
    if (arg == "-r") :
        release = True
    if (arg == "-c") :
        clear = True
    if (arg == "-t") :
        test = True

    # Clear before start
    clear_all()
    if clear :
        print("Clear done!")
        exit(0)

    # Make content for release?
    if release:
        print("===Make app content for release...")
    else:
        print("===Make app content for debug...")
    make_out()
    print("Prepare - OK")

    # Copy content and database
    source = get_working_dir() + "/" + CONTENT_SOURCE_DIR
    shutil.copytree(source, get_out_dir() + "/tmp", False, None)
    copy_db(release)
    print("Content - OK")
    if DEBUG :
        print("    source - " + source)

    # Zip content
    zip_file = zipfile.ZipFile(get_out_dir() + '/content.zip', 'w', zipfile.ZIP_DEFLATED)
    zip_dir(get_out_dir() + "/tmp/", zip_file)
    encode()

    # Finish
    shutil.rmtree(get_out_dir() + "/tmp", True, None)
    print("===Done!")

#---------------------------------------------------------------------------------------------------
