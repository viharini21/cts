import { provideRouter } from '@angular/router';
import { provideHttpClient } from '@angular/common/http';
import { ComponentFixture, TestBed } from '@angular/core/testing';
import { By } from '@angular/platform-browser';

import { CourseCard } from './course-card';

describe('CourseCard', () => {
  let component: CourseCard;
  let fixture: ComponentFixture<CourseCard>;

  const mockCourse = {
    id: 1,
    name: 'Data Structures',
    code: 'CS101',
    credits: 4,
    gradeStatus: 'passed' as const,
  };

  beforeEach(async () => {
    await TestBed.configureTestingModule({ providers: [provideHttpClient(), provideRouter([])], 
      imports: [CourseCard],
    }).compileComponents();

    fixture = TestBed.createComponent(CourseCard);
    component = fixture.componentInstance;
  });

  it('should create', () => {
    component.course = mockCourse;
    fixture.detectChanges();
    expect(component).toBeTruthy();
  });

  it('should render input course name', () => {
    component.course = mockCourse;
    fixture.detectChanges();

    const title = fixture.debugElement.query(By.css('h3')).nativeElement as HTMLElement;
    expect(title.textContent).toContain('Data Structures');
  });

  it('should emit enrollRequested when enroll is clicked', () => {
    component.course = mockCourse;
    fixture.detectChanges();

    spyOn(component.enrollRequested, 'emit');
    const buttons = fixture.debugElement.queryAll(By.css('button'));
    buttons[0].nativeElement.click();
    fixture.detectChanges();

    expect(component.enrollRequested.emit).toHaveBeenCalledWith(1);
  });

  it('should log changes in ngOnChanges', () => {
    const logSpy = spyOn(console, 'log');
    component.ngOnChanges({
      course: {
        previousValue: undefined,
        currentValue: mockCourse,
        firstChange: true,
        isFirstChange: () => true,
      },
    });

    expect(logSpy).toHaveBeenCalled();
  });

  it('should apply full-card class for 4 credits', () => {
    component.course = mockCourse;
    fixture.detectChanges();

    const card = fixture.debugElement.query(By.css('.card')).nativeElement as HTMLElement;
    expect(card.className).toContain('card--full');
  });
});
