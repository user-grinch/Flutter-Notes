class CloudStorageExceptions implements Exception {
  const CloudStorageExceptions();
}

class CouldNotCreateNoteException implements CloudStorageExceptions {}

class CouldNotGetNoteException implements CloudStorageExceptions {}

class CouldNotUpdateNoteException implements CloudStorageExceptions {}

class CouldNotDeleteNoteException implements CloudStorageExceptions {}
