allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

// Ensure Android library plugins (from Flutter packages) have a compileSdk set
// This avoids build failures when third-party plugins don't declare it explicitly.
subprojects {
    plugins.withId("com.android.library") {
        // Configure the Android 'library' extension if present
        extensions.configure<com.android.build.gradle.LibraryExtension>("android") {
            // Choose a compileSdk that matches Flutter's current defaults
            // If Flutter updates, this can be bumped (e.g., 35 for Android 15)
            compileSdk = 34
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
