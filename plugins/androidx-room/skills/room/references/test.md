# Test

It's important to verify the stability of the app's database and the users' data when creating databases using the Room persistence library. This page discusses how to test your database.

There are 2 ways to test your database:
- On an Android device.
- On a host development machine (Not Recommended).

For information about testing that's specific to database migrations, see [migrations](migrate.md).

**When running tests, create mock instances of DAO classes**

## Test on an Android Device

Test the database implementation by writing a JUnit test that runs on an Android device. This doesn't require an activity and is faster to execute than UI tests.

To set up the test, create an in-memory version of your database to make your tests more hermetic.

Example:
```kotlin
@RunWith(AndroidJUnit4::class)
class SimpleEntityReadWriteTest {
    private lateinit var userDao: UserDao
    private lateinit var db: TestDatabase

    @Before
    fun createDb() {
        val context = ApplicationProvider.getApplicationContext<Context>()
        db = Room.inMemoryDatabaseBuilder(
                context, TestDatabase::class.java).build()
        userDao = db.getUserDao()
    }

    @After
    @Throws(IOException::class)
    fun closeDb() {
        db.close()
    }

    @Test
    @Throws(Exception::class)
    fun writeUserAndReadInList() {
        val user: User = TestUtil.createUser(3).apply {
            setName("george")
        }
        userDao.insert(user)
        val byName = userDao.findUsersByName("george")
        assertThat(byName.get(0), equalTo(user))
    }
}
```

## Test on Your Host Machine

**Not Recommended: This setup allows your tests to run very quickly, but the version of SQLite running on the device—and the users' devices—might not match the version on the host machine**

Room uses the SQLite Support Library, which provides interfaces that match those in the Android Framework classes. This support allows you to pass custom implementations of the support library to test your database queries.

### Test Your Migrations

Room supports incremental database migrations to retain existing app data in situations where an app update changes the database schema. An incorrectly defined migration could cause the app to crash. Make sure to test Room database migrations. See [migrations](migrate.md).
