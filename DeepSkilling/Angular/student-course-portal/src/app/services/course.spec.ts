import { provideHttpClient } from '@angular/common/http';
import { provideRouter } from '@angular/router';
import { TestBed } from '@angular/core/testing';
import { provideHttpClientTesting, HttpTestingController } from '@angular/common/http/testing';

import { CourseService } from './course';

describe('CourseService', () => {
  let service: CourseService;
  let httpMock: HttpTestingController;

  const mockCourses = [
    { id: 1, name: 'Data Structures', code: 'CS101', credits: 4, gradeStatus: 'passed' as const },
    {
      id: 2,
      name: 'Angular Fundamentals',
      code: 'NG201',
      credits: 3,
      gradeStatus: 'pending' as const,
    },
  ];

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [provideHttpClient(), provideHttpClientTesting(), provideRouter([]), CourseService],
    });

    service = TestBed.inject(CourseService);
    httpMock = TestBed.inject(HttpTestingController);
  });

  afterEach(() => {
    httpMock.verify();
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('should call getCoursesHttp with the expected URL', () => {
    service.getCoursesHttp().subscribe((courses) => {
      expect(courses.length).toBe(2);
    });

    const req = httpMock.expectOne('http://localhost:3000/courses');
    expect(req.request.method).toBe('GET');
    req.flush(mockCourses);
  });

  it('should map API error to a user-friendly message', () => {
    service.getCoursesHttp().subscribe({
      next: () => fail('Expected an error response'),
      error: (error: Error) => {
        expect(error.message).toBe('Failed to load courses. Please try again.');
      },
    });

    const req1 = httpMock.expectOne('http://localhost:3000/courses');
    req1.flush('Server error', { status: 500, statusText: 'Server Error' });

    const req2 = httpMock.expectOne('http://localhost:3000/courses');
    req2.flush('Server error', { status: 500, statusText: 'Server Error' });

    const req3 = httpMock.expectOne('http://localhost:3000/courses');
    req3.flush('Server error', { status: 500, statusText: 'Server Error' });
  });
});
