import json
import os
import shutil

with open('info.json') as infoFile:
  modInfo = json.load(infoFile)
  
if modInfo is not None:
  modName = modInfo['name']
  modVersion = modInfo['version']

  modFileName = modName + '_' + modVersion
  tempDir = os.path.join ('.', 'tmp')
  modDir = os.path.join(tempDir, modFileName)
  
  shutil.copytree('.', modDir, ignore=shutil.ignore_patterns('*.py', '.git'))
  shutil.make_archive(modFileName, 'zip', tempDir)
  shutil.rmtree(tempDir)