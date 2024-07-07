import Dependencies

extension AppFilesManager: TestDependencyKey {
    public static var testValue: Self {
        return Self { _ in
            nil
        } removeSavedFiles: {

        } getSavedFiles: {
            []
        }
    }
}
