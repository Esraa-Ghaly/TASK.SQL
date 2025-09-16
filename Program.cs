using StudentSystem.Data;
using StudentSystem.Models;

namespace StudentSystem
{
    internal class Program
    {
        static void Main(string[] args)
        {
            using var context = new StudentSystemContext();
            context.Database.EnsureCreated();
            SeedDatabase(context);

            static void SeedDatabase(StudentSystemContext context)
            {
                if (!context.Students.Any())
                {
                    var students = new List<Student>
        {
            new Student { Name = "Esraa", PhoneNumber = "01012345678", RegisteredOn = DateTime.Now },
            new Student { Name = "Amal", PhoneNumber = "01198765432", RegisteredOn = DateTime.Now }
        };

                    var courses = new List<Course>
        {
            new Course { Name = "C#", Description = "Intro to C#", StartDate = DateTime.Now, EndDate = DateTime.Now.AddMonths(2), Price = 500 },
            new Course { Name = "SQL Course", Description = "Advanced SQL", StartDate = DateTime.Now, EndDate = DateTime.Now.AddMonths(1), Price = 750 }
        };

                    var resources = new List<Resource>
        {
            new Resource { Name = "C# Slides", Url = "http://example.com/csharp",  CourseId = 1 },
            new Resource { Name = "SQL Video", Url = "http://example.com/sql",  CourseId = 2 }
        };

                    var homeworks = new List<Homework>
        {
            new Homework { Content = "C# Task", SubmissionTime = DateTime.Now, StudentId = 1, CourseId = 1 },
            new Homework { Content = "SQL Task", SubmissionTime = DateTime.Now, StudentId = 2, CourseId = 2 }
        };

                    context.Students.AddRange(students);
                    context.Courses.AddRange(courses);
                    context.Resources.AddRange(resources);
                    context.Homeworks.AddRange(homeworks);

                    context.SaveChanges();
                }
                {

                }
            }
        }
    }
}
