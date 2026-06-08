# Test

It's important to verify the stability of the app's database and the users' data when creating databases using the Room persistence library. This page discusses how to test your database.

There are 2 ways to test your database:
- On an Android device.
- On a host development machine (Not Recommended).

For information about testing that's specific to database migrations, see [Test Migrations](migrate.md#test-migrations).

> [!NOTE]
> When running tests, you can create mock instances of your [DAO](../api/annotations/dao.md) classes — you don't need a full database if you aren't testing the database itself. This works because DAOs don't leak any details of the database.

## Test on an Android Device

Test the database implementation by writing a JUnit test that runs on an Android device. This doesn't require an activity and is faster to execute than UI tests.

To set up the test, create an in-memory version of your database to make your tests more hermetic.

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

> [!NOTE]
> This setup runs tests very quickly but isn't recommended: the version of SQLite on the host machine might not match the version on the device or on users' devices.

Room uses the SQLite Support Library, which provides interfaces that match those in the Android Framework classes. This support allows you to pass custom implementations of the support library to test your database queries.

## Test Your Migrations

Room supports incremental database migrations to retain existing app data in situations where an app update changes the database schema. An incorrectly defined migration could cause the app to crash. Make sure to test Room database migrations. See [Test Migrations](migrate.md#test-migrations).
